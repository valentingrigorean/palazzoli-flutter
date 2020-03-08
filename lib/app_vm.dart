import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:lightingPalazzoli/palazzoli_theme_data.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:pigment/pigment.dart';
import 'package:quiver/strings.dart';
import 'package:redux/redux.dart';

class AppViewModel extends Equatable {
  final PalazzoliThemeData themeData;

  AppViewModel({this.themeData}) : super([themeData]);

  factory AppViewModel.fromStore(Store<AppState> store) {
    var appConfig = store.state.appConfig;

    var theme = PalazzoliThemeData();

    if (appConfig != null) {
      theme = theme.copyWith(
          logo: appConfig.logo,
          appBarColor: _getColor(appConfig.backgroundTopBarColor),
          appBarIconColor: _getColor(appConfig.iconTopBarColor),
          backgroundColor: _getColor(appConfig.backgroundPageColor),
          backgroundButtonColor: _getColor(appConfig.backgroundButtonColor),
          textButtonColor: _getColor(appConfig.textButtonColor),
          iconColor: _getColor(appConfig.iconLowBarSelected),
          backgroundTabBarColor: _getColor(appConfig.backgroundLowBarColor),
          selectedTabBarColor: _getColor(appConfig.iconLowBarSelected),
          unselectedTabBarColor: _getColor(appConfig.iconLowBarUnselected),
          backgroundHeaderColor: _getColor(appConfig.iconLowBarSelected),
          titleHeaderColor: _getColor(appConfig.titleAccordionOpenColor),
          subtitleHeaderColor: _getColor(appConfig.subtitleAccordionOpenColor),
          titleItemColor: _getColor(appConfig.titleAccordionCloseColor),
          subtitleItemColor: _getColor(appConfig.subtitleAccordionCloseColor));
    }

    return AppViewModel(themeData: theme);
  }

  static Color _getColor(String hexColor) {
    if (isBlank(hexColor)) {
      return null;
    }
    try {
      var color = Pigment.fromString(hexColor);
      return color;
    } catch (e) {
      return null;
    }
  }
}
