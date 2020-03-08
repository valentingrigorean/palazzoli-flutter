import 'package:lightingPalazzoli/models/activity.dart';
import 'package:lightingPalazzoli/redux/app/app_actions.dart';

class LoadActivityAction extends StartLoadingAction {}

class LoadedActivityAction extends StopLoadingAction {
  final ActivityList items;

  LoadedActivityAction(this.items);
}
