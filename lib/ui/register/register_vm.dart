import 'package:flutter/cupertino.dart';
import 'package:lightingPalazzoli/models/activity.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';
import 'package:redux/redux.dart';

class RegisterViewModel extends BaseViewModel {
  final ActivityList items;

  RegisterViewModel({this.items}) : super(props: [items]);

  factory RegisterViewModel.fromStore(
      Store<AppState> store, BuildContext context) {
    var appState = store.state;
    return RegisterViewModel(
      items: appState.dataState.activities,
    );
  }
}
