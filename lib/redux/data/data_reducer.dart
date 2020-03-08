import 'package:lightingPalazzoli/redux/data/data_actions.dart';
import 'package:lightingPalazzoli/redux/data/data_state.dart';
import 'package:redux/redux.dart';

final dataReducer = combineReducers<DataState>([
  TypedReducer<DataState, LoadedActivityAction>(_onLoadedActivity),
]);

DataState _onLoadedActivity(DataState state, LoadedActivityAction action) {
  return DataState(activities: action.items);
}
