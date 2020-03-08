import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/palazzoli_theme_data.dart';

class PalazzoliTheme extends StatelessWidget {
  final PalazzoliThemeData data;
  final Widget child;

  const PalazzoliTheme({Key key, @required this.data, @required this.child})
      : assert(child != null),
        assert(data != null),
        super(key: key);

  static PalazzoliThemeData of(BuildContext context) {
    final _InheritedTheme inheritedTheme =
        context.inheritFromWidgetOfExactType(_InheritedTheme);

    final PalazzoliThemeData theme =
        inheritedTheme?.theme?.data ?? PalazzoliThemeData();

    return theme;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: IconTheme(
        data: _getIconThemData(data.iconColor),
        child: CupertinoTheme(
          // We're using a MaterialBasedCupertinoThemeData here instead of a
          // CupertinoThemeData because it defers some properties to the Material
          // ThemeData.
          data: MaterialBasedCupertinoThemeData(
            materialTheme: data.toThemeData(),
          ),
          child: child,
        ),
      ),
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

class _InheritedTheme extends InheritedWidget {
  const _InheritedTheme({
    Key key,
    @required this.theme,
    @required Widget child,
  })  : assert(theme != null),
        super(key: key, child: child);

  final PalazzoliTheme theme;

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}
