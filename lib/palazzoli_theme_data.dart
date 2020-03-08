import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

const kDefaultPrimaryColor = Color(0xFF2975C0);
const kDefaultUnselectedColor = Color(0xFFC9C9C9);
const kDefaultDividerColor = Color(0xFFF0F0F0);
const kDefaultDisabledColor = Color(0x66C9C9C9);

class PalazzoliThemeData extends Equatable {
  final String logo;
  final Color appBarColor;
  final Color appBarIconColor;
  final Color backgroundColor;
  final Color backgroundButtonColor;
  final Color textButtonColor;
  final Color iconColor;
  final Color backgroundTabBarColor;
  final Color selectedTabBarColor;
  final Color unselectedTabBarColor;
  final Color backgroundHeaderColor;
  final Color titleHeaderColor;
  final Color subtitleHeaderColor;
  final Color backgroundItemColor;
  final Color titleItemColor;
  final Color subtitleItemColor;
  final Color dividerColor;
  final Color disabledColor;
  final TextTheme textTheme;

  PalazzoliThemeData(
      {this.logo = 'http://89.35.124.29/Content/images/logo.png',
      this.appBarColor = kDefaultPrimaryColor,
      this.appBarIconColor = Colors.white,
      this.backgroundColor = Colors.white,
      this.backgroundButtonColor = kDefaultPrimaryColor,
      this.textButtonColor = Colors.white,
      this.iconColor = kDefaultPrimaryColor,
      this.backgroundTabBarColor = Colors.white,
      this.selectedTabBarColor = kDefaultPrimaryColor,
      this.unselectedTabBarColor = kDefaultUnselectedColor,
      this.backgroundHeaderColor = kDefaultPrimaryColor,
      this.titleHeaderColor = Colors.white,
      this.subtitleHeaderColor = Colors.white,
      this.backgroundItemColor = Colors.white,
      this.titleItemColor = const Color(0xFF1F1F1F),
      this.subtitleItemColor = kDefaultUnselectedColor,
      this.dividerColor = kDefaultDividerColor,
      this.disabledColor = kDefaultDisabledColor,
      TextTheme textTheme})
      : this.textTheme =
            textTheme ?? Typography().white.apply(fontFamily: 'SourceSansPro'),
        super([
          logo,
          appBarColor,
          appBarIconColor,
          backgroundColor,
          backgroundButtonColor,
          textButtonColor,
          iconColor,
          backgroundTabBarColor,
          selectedTabBarColor,
          unselectedTabBarColor,
          backgroundHeaderColor,
          titleHeaderColor,
          subtitleHeaderColor,
          backgroundItemColor,
          titleItemColor,
          subtitleItemColor,
          dividerColor,
          disabledColor,
          textTheme
        ]);

  ThemeData toThemeData() {
    final ThemeData base = ThemeData(fontFamily: 'SourceSansPro');
    return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
          color: appBarColor,
          iconTheme: _getIconThemData(appBarIconColor),
          actionsIconTheme: _getIconThemData(appBarIconColor)),
      iconTheme: _getIconThemData(iconColor),
      backgroundColor: backgroundColor,
      disabledColor: disabledColor,
      unselectedWidgetColor: unselectedTabBarColor,
      dividerColor: dividerColor,
      textTheme: textTheme.copyWith(button: textTheme.button.copyWith(color: Colors.white)),
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: backgroundButtonColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3))),
        textTheme: base.buttonTheme.textTheme,
      ),

      scaffoldBackgroundColor: backgroundColor,
      bottomAppBarTheme:
          base.bottomAppBarTheme.copyWith(color: backgroundTabBarColor),
    );
  }

  PalazzoliThemeData copyWith({String logo, Color appBarColor, Color appBarIconColor, Color backgroundColor, Color backgroundButtonColor, Color textButtonColor, Color iconColor, Color backgroundTabBarColor, Color selectedTabBarColor, Color unselectedTabBarColor, Color backgroundHeaderColor, Color titleHeaderColor, Color subtitleHeaderColor, Color backgroundItemColor, Color titleItemColor, Color subtitleItemColor, Color dividerColor, Color disabledColor, TextTheme textTheme}) {
    return PalazzoliThemeData(
      logo: logo ?? this.logo,
      appBarColor: appBarColor ?? this.appBarColor,
      appBarIconColor: appBarIconColor ?? this.appBarIconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundButtonColor: backgroundButtonColor ?? this.backgroundButtonColor,
      textButtonColor: textButtonColor ?? this.textButtonColor,
      iconColor: iconColor ?? this.iconColor,
      backgroundTabBarColor: backgroundTabBarColor ?? this.backgroundTabBarColor,
      selectedTabBarColor: selectedTabBarColor ?? this.selectedTabBarColor,
      unselectedTabBarColor: unselectedTabBarColor ?? this.unselectedTabBarColor,
      backgroundHeaderColor: backgroundHeaderColor ?? this.backgroundHeaderColor,
      titleHeaderColor: titleHeaderColor ?? this.titleHeaderColor,
      subtitleHeaderColor: subtitleHeaderColor ?? this.subtitleHeaderColor,
      backgroundItemColor: backgroundItemColor ?? this.backgroundItemColor,
      titleItemColor: titleItemColor ?? this.titleItemColor,
      subtitleItemColor: subtitleItemColor ?? this.subtitleItemColor,
      dividerColor: dividerColor ?? this.dividerColor,
      disabledColor: disabledColor ?? this.disabledColor,
      textTheme: textTheme ?? this.textTheme,
    );
  }

  IconThemeData _getIconThemData(Color color) {
    return IconThemeData(
      color: color,
      opacity: 1,
      size: 24,
    );
  }
}
