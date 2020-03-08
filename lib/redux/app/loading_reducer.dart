import 'package:lightingPalazzoli/redux/app/app_actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, StartLoadingAction>(_setLoading),
  TypedReducer<bool, StopLoadingAction>(_setLoaded),
]);

bool _setLoading(bool state, StartLoadingAction action) {
  return true;
}

bool _setLoaded(bool state, StopLoadingAction action) {
  return false;
}
