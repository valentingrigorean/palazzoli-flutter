import 'package:lightingPalazzoli/redux/search/search_actions.dart';
import 'package:lightingPalazzoli/redux/search/search_state.dart';
import 'package:redux/redux.dart';

final searchReducer = combineReducers<SearchState>([
  TypedReducer<SearchState, SearchLoadingAction>(_onLoad),
  TypedReducer<SearchState, SearchErrorAction>(_onError),
  TypedReducer<SearchState, SearchResultAction>(_onResult),
  TypedReducer<SearchState, ClearSearchAction>(_clearSearch),
]);

SearchState _onLoad(SearchState state, SearchLoadingAction action) {
  if (action is SearchAction)
    return SearchState(isLoading: true, items: action.items);
  return SearchState.loading();
}

SearchState _onResult(SearchState state, SearchResultAction action) {
  return state.copyWith(items: action.items, isLoading: false);
}

SearchState _onError(SearchState state, SearchErrorAction action) {
  return SearchState.error();
}

SearchState _clearSearch(SearchState state, ClearSearchAction action) {
  return SearchState();
}
