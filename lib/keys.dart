import 'package:flutter/cupertino.dart';
import 'package:lightingPalazzoli/ui/bottom_navigation_bar_controller.dart';

class PalazzoliKeys {
  PalazzoliKeys._();

  static GlobalKey<BottomNavigationBarControllerState> bottomNavigationKey =
      GlobalKey<BottomNavigationBarControllerState>();

  static GlobalKey<NavigatorState> catalogNavigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> favoriteNavigatorKey =
      GlobalKey<NavigatorState>();
}
