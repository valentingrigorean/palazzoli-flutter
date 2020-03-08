import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';

class CustomRadio<T> extends StatelessWidget {
  final String text;
  final T value;
  final T groupValue;
  final ValueSetter<T> onChanged;

  const CustomRadio(
      {Key key,
      this.text,
      @required this.value,
      @required this.groupValue,
      @required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = PalazzoliTheme.of(context);
    var textStyle = theme.textTheme.body1.copyWith(
        color: value == groupValue
            ? theme.selectedTabBarColor
            : theme.unselectedTabBarColor);

    return Row(
      children: <Widget>[
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: theme.selectedTabBarColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        GestureDetector(
            onTap: () => onChanged(value), child: Text(text, style: textStyle)),
      ],
    );
  }
}
