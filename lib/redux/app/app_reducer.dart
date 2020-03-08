import 'package:lightingPalazzoli/data/network/constants/endpoints.dart';
import 'package:lightingPalazzoli/models/app_config.dart';
import 'package:lightingPalazzoli/redux/app/app_actions.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/app/error_reducer.dart';
import 'package:lightingPalazzoli/redux/app/loading_reducer.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_reducer.dart';
import 'package:lightingPalazzoli/redux/data/data_reducer.dart';
import 'package:lightingPalazzoli/redux/favorite/favorite_reducer.dart';
import 'package:lightingPalazzoli/redux/search/search_reducer.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, dynamic action) {
  print(action);
  return state.copyWith(
      isLoading: loadingReducer(state.isLoading, action),
      appConfig: appConfigReducer(state.appConfig, action),
      dataState: dataReducer(state.dataState, action),
      catalogState: catalogReducer(state.catalogState, action),
      favoriteState: favoriteReducer(state.favoriteState, action),
      searchState: searchReducer(state.searchState, action),
      errorState: errorReducer(state.errorState, action));
}

final appConfigReducer = combineReducers<AppConfig>(
    [TypedReducer<AppConfig, LoadedAppConfigAction>(_onLoadedAppConfig)]);

AppConfig _onLoadedAppConfig(
    AppConfig appConfig, LoadedAppConfigAction action) {
  Endpoints.basePhotoUrl = action.appConfig.pathImageDigital;
  return action.appConfig;
}
