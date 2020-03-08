import 'package:flutter/material.dart';

class CustomNavigation extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final RouteFactory onGenerateRoute;

  const CustomNavigation(
      {Key key, @required this.navigatorKey, @required this.onGenerateRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => ! await navigatorKey.currentState.maybePop(),
      child: Navigator(key: navigatorKey, onGenerateRoute: onGenerateRoute),
    );
  }
}
