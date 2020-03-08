import 'package:equatable/equatable.dart';
import 'package:lightingPalazzoli/models/app_config.dart';
import 'package:lightingPalazzoli/redux/app/error_state.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_state.dart';
import 'package:lightingPalazzoli/redux/data/data_state.dart';
import 'package:lightingPalazzoli/redux/favorite/favorite_state.dart';
import 'package:lightingPalazzoli/redux/search/search_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState extends Equatable {
  final bool isLoading;
  final AppConfig appConfig;
  final DataState dataState;
  final CatalogState catalogState;
  final FavoriteState favoriteState;
  final ErrorState errorState;
  final SearchState searchState;

  AppState(
      {this.dataState,
      this.isLoading,
      this.appConfig,
      this.catalogState,
      this.favoriteState,
      this.searchState,
      this.errorState})
      : super([
          dataState,
          isLoading,
          appConfig,
          catalogState,
          favoriteState,
          searchState,
          errorState
        ]);

  factory AppState.initial() => AppState(
      isLoading: false,
      dataState: DataState(),
      favoriteState: FavoriteState.initial(),
      catalogState: CatalogState(),
      searchState: SearchState(),
      errorState: ErrorState.initial());

  bool get hasError => errorState.hasError;

  AppState copyWith(
      {DataState dataState,
      bool isLoading,
      AppConfig appConfig,
      CatalogState catalogState,
      FavoriteState favoriteState,
      SearchState searchState,
      ErrorState errorState}) {
    return AppState(
        dataState: dataState ?? this.dataState,
        isLoading: isLoading ?? this.isLoading,
        appConfig: appConfig ?? this.appConfig,
        catalogState: catalogState ?? this.catalogState,
        favoriteState: favoriteState ?? this.favoriteState,
        searchState: searchState ?? this.searchState,
        errorState: errorState ?? this.errorState);
  }
}
