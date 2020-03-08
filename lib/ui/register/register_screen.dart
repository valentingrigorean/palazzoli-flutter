import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:lightingPalazzoli/data/network/catalog_api.dart';
import 'package:lightingPalazzoli/data/sharedpref/shared_preference_helper.dart';
import 'package:lightingPalazzoli/generated/i18n.dart';
import 'package:lightingPalazzoli/keys.dart';
import 'package:lightingPalazzoli/models/register.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/redux/data/data_actions.dart';
import 'package:lightingPalazzoli/ui/bottom_navigation_bar_controller.dart';
import 'package:lightingPalazzoli/ui/register/register_form_widget.dart';
import 'package:lightingPalazzoli/ui/register/register_vm.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';
import 'package:lightingPalazzoli/widgets/custom_app_bar.dart';
import 'package:lightingPalazzoli/widgets/loading_widget.dart';
import 'package:lightingPalazzoli/widgets/no_animation_route.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var theme = PalazzoliTheme.of(context);

    return ContentWidget<RegisterViewModel>(
      dispatchAction: LoadActivityAction(),
      converter: (store) => RegisterViewModel.fromStore(store, context),
      viewModelBuilder: (context, vm) {
        return Scaffold(
          appBar: CustomAppBar(
            showSearchAction: false,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              FormKeyboardActions(
                child: RegisterFormWidget(
                  viewModel: vm,
                  onRegister: _onRegister,
                  onSendLatter: _onSendLatter,
                ),
                autoScroll: true,
              ),
              Offstage(
                offstage: !_isLoading,
                child: AbsorbPointer(
                  child: Container(
                    color: theme.selectedTabBarColor.withOpacity(0.3),
                    child: LoadingWidget(),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _onSendLatter() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 100))..then((d) => _goHome());

    setState(() {
      _isLoading = false;
    });
  }

  void _onRegister(Register register, Completer<bool> completer) {
    setState(() {
      _isLoading = true;
    });

    _register(register).then((success) {
      completer.complete(success);
      _showDoneDialog(success);
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _showDoneDialog(bool success) {
    var localization = S.of(context);
    var theme = PalazzoliTheme.of(context);
    var messageStyle = theme.textTheme.body1.copyWith(color: Colors.black);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(
              success
                  ? localization.register_done
                  : localization.error_unexpected,
              style: messageStyle,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(localization.general_ok),
                onPressed: () {
                  Navigator.of(context).pop();

                  if (success) {
                    SharedPreferenceHelper.instance.setHasRegisterData(true);
                    _goHome();
                  }
                },
              )
            ],
          );
        });
  }

  void _goHome() {
    Navigator.of(context).pushReplacement(
      NoAnimationRoute(
        builder: (context) => BottomNavigationBarController(
          key: PalazzoliKeys.bottomNavigationKey,
        ),
      ),
    );
  }

  Future<bool> _register(Register register) async {
    try {
      var api = CatalogApi();
      return api.saveInfo(register);
    } catch (e) {
      print('Failed to register:$e');
      return false;
    }
  }
}
