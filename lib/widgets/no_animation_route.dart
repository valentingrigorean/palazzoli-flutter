import 'package:flutter/material.dart';

class NoAnimationRoute<T> extends MaterialPageRoute<T> {
  NoAnimationRoute(
      {@required WidgetBuilder builder,
      RouteSettings settings,
      bool maintainState = true,
      bool fullscreenDialog = false})
      : super(
            builder: builder,
            settings: settings,
            maintainState: maintainState,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
