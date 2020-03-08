import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/widgets/custom_app_bar.dart';

class TabContentWidget extends StatelessWidget {
  final Widget child;
  final Widget floatingActionButton;

  const TabContentWidget({Key key, this.child, this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: child,
      floatingActionButton: floatingActionButton,
    );
  }
}
