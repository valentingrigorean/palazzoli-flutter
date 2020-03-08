import 'package:lightingPalazzoli/models/app_config.dart';

class StartLoadingAction {}

class StopLoadingAction {}

class ErrorAction extends StopLoadingAction {
  final dynamic error;
  final String message;
  final dynamic action;
  final bool hasConnection;

  ErrorAction({this.error, this.message, this.action, this.hasConnection});
}

class ClearErrorAction extends StopLoadingAction {}

class LoadAppConfigAction extends StartLoadingAction {}

class LoadedAppConfigAction extends StopLoadingAction {
  final AppConfig appConfig;

  LoadedAppConfigAction({this.appConfig});
}
