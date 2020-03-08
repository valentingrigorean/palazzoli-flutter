import 'package:lightingPalazzoli/redux/app/app_actions.dart';
import 'package:lightingPalazzoli/redux/app/error_state.dart';
import 'package:redux/redux.dart';

final errorReducer = combineReducers<ErrorState>([
  TypedReducer<ErrorState, ErrorAction>(_onError),
  TypedReducer<ErrorState, ClearErrorAction>(_clearError),
]);

ErrorState _onError(ErrorState state, ErrorAction e) {
  return ErrorState(
      error: e.error,
      message: e.message,
      action: e.action,
      hasConnection: e.hasConnection);
}

ErrorState _clearError(ErrorState state, ClearErrorAction e) {
  return ErrorState.initial();
}
