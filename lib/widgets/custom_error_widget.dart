import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/generated/i18n.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final String button;
  final Color textColor;
  final VoidCallback callback;

  const CustomErrorWidget(
      {Key key,
      this.message,
      this.button,
      this.callback,
      this.textColor = Colors.black})
      : super(key: key);

  factory CustomErrorWidget.fromViewModel(ErrorViewModel errorViewModel,
      {Color textColor = Colors.black}) {
    return CustomErrorWidget(
      message: errorViewModel.message,
      callback: () => errorViewModel.retry(errorViewModel.action),
      textColor: textColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    var buttonText = button ?? S.of(context).general_try_again;
    var theme = PalazzoliTheme.of(context);
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(message,
              textAlign: TextAlign.center,
              style: theme.textTheme.body1.copyWith(color: textColor)),
          SizedBox(
            height: 16,
          ),
          RaisedButton(
              onPressed: callback,
              child: Text(buttonText, style: theme.textTheme.button))
        ],
      ),
    );
  }
}
