import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:lightingPalazzoli/data/network/catalog_api.dart';
import 'package:lightingPalazzoli/generated/i18n.dart';
import 'package:lightingPalazzoli/main.dart';
import 'package:lightingPalazzoli/models/mail_info.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/ui/info/info_form_widget.dart';
import 'package:lightingPalazzoli/ui/tab_content_widget.dart';
import 'package:lightingPalazzoli/widgets/loading_widget.dart';

class InfoScreen extends StatelessWidget {
  final String productCode;

  const InfoScreen({Key key, this.productCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabContentWidget(
      child: _InfoScreen(productCode: productCode),
    );
  }
}

class _InfoScreen extends StatefulWidget {
  final String productCode;

  const _InfoScreen({Key key, this.productCode}) : super(key: key);

  @override
  __InfoScreenState createState() => __InfoScreenState();
}

class __InfoScreenState extends State<_InfoScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var theme = PalazzoliTheme.of(context);

    return Stack(fit: StackFit.expand, children: <Widget>[
      FormKeyboardActions(
        child: InfoFormWidget(
          productCode: widget.productCode,
          onSend: _onSendEmail,
        ),
        autoScroll: true,
      ),
      Offstage(
          offstage: !_isLoading,
          child: AbsorbPointer(
              child: Container(
                  color: theme.selectedTabBarColor.withOpacity(0.3),
                  child: LoadingWidget())))
    ]);
  }

  void _onSendEmail(MailInfo mailInfo, Completer<bool> completer) {
    setState(() {
      _isLoading = true;
    });
    _sendEmail(mailInfo).then((success) {
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
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(
              success
                  ? localization.info_mail_send
                  : localization.error_unexpected,
              style: messageStyle,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(localization.general_close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<bool> _sendEmail(MailInfo mailInfo) async {
    try {
      var api = CatalogApi();
      return await api.sendMail(mailInfo);
    } catch (e, s) {
      reportError(e, s);
      return false;
    }
  }
}
