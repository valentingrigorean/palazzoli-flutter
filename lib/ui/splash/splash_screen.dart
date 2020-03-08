import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lightingPalazzoli/data/sharedpref/shared_preference_helper.dart';
import 'package:lightingPalazzoli/keys.dart';
import 'package:lightingPalazzoli/redux/app/app_actions.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/ui/bottom_navigation_bar_controller.dart';
import 'package:lightingPalazzoli/ui/register/register_screen.dart';
import 'package:lightingPalazzoli/ui/splash/splash_vm.dart';
import 'package:lightingPalazzoli/widgets/custom_error_widget.dart';
import 'package:lightingPalazzoli/widgets/loading_widget.dart';
import 'package:lightingPalazzoli/widgets/no_animation_route.dart';
import 'package:quiver/strings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _startNavigate = false;
  DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SplashViewModel>(
      onInit: (store) => store.dispatch(LoadAppConfigAction()),
      converter: (store) => SplashViewModel.fromStore(store, context),
      distinct: true,
      builder: (context, vm) {
        var errorWidget = vm.errorViewModel == null
            ? null
            : CustomErrorWidget.fromViewModel(vm.errorViewModel,
                textColor: Colors.white);

        var overlayWidget = errorWidget ?? LoadingWidget();

        if (vm.success) _navigateToHome();
        return Stack(
            fit: StackFit.expand,
            children: <Widget>[_getSplashImage(vm), overlayWidget]);
      },
    );
  }

  Widget _getSplashImage(SplashViewModel viewModel) {
    if (isBlank(viewModel.splash)) {
      return SizedBox();
    }
    return Image(
        image: CachedNetworkImageProvider(viewModel.splash), fit: BoxFit.fill);
  }

  void _navigateToHome() async {
    if (_startNavigate) return;
    _startNavigate = true;

    var sleepTime = DateTime.now().difference(_startTime).inSeconds;
    sleepTime = max(5 - sleepTime, 0);
    bool hasRegisterData =
        await SharedPreferenceHelper.instance.hasRegisterData;
    Future.delayed(Duration(seconds: sleepTime)).then((_) {
      Navigator.of(context).pushReplacement(
        NoAnimationRoute(
          builder: (context) => hasRegisterData
              ? BottomNavigationBarController(
                  key: PalazzoliKeys.bottomNavigationKey,
                )
              : RegisterScreen(),
        ),
      );
    });
  }
}
