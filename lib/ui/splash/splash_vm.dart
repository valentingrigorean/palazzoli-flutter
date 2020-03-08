import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';
import 'package:redux/redux.dart';

class SplashViewModel extends BaseViewModel {
  final bool success;
  final ErrorViewModel errorViewModel;
  final String splash;

  SplashViewModel(
      {this.success, this.splash, this.errorViewModel, bool isLoading})
      : super(props: [success, splash, errorViewModel], isLoading: isLoading);

  factory SplashViewModel.fromStore(
      Store<AppState> store, BuildContext context) {
    return SplashViewModel(
        splash: store.state.appConfig?.splashPage,
        errorViewModel: ErrorViewModel.fromStore(store, context),
        success: !store.state.hasError && store.state.appConfig != null,
        isLoading: store.state.isLoading);
  }
}
