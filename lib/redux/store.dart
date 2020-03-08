import 'package:lightingPalazzoli/data/network/catalog_api.dart';
import 'package:lightingPalazzoli/data/repository.dart';
import 'package:lightingPalazzoli/redux/app/app_midleware.dart';
import 'package:lightingPalazzoli/redux/app/app_reducer.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_midleware.dart';
import 'package:lightingPalazzoli/redux/data/data_midleware.dart';
import 'package:lightingPalazzoli/redux/favorite/favorite_actions.dart';
import 'package:lightingPalazzoli/redux/favorite/favorite_middleware.dart';
import 'package:lightingPalazzoli/redux/search/search_middleware.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

Future<Store<AppState>> createStore() async {
  var store = Store(appReducer,
      initialState: AppState.initial(),
      distinct: true,
      middleware: createStoreMiddleware());

  store.dispatch(LoadFavoriteAction());
  return store;
}

List<Middleware<AppState>> createStoreMiddleware() {
  var repository = Repository();
  return <Middleware<AppState>>[
        EpicMiddleware<AppState>(AppConfigMiddleware(repository)),
        EpicMiddleware<AppState>(CatalogMiddleware(repository)),
        EpicMiddleware<AppState>(CategoryMiddleware(repository)),
        EpicMiddleware<AppState>(SubcategoryMiddleware(repository)),
        EpicMiddleware<AppState>(ProductMiddleware(repository)),
        EpicMiddleware<AppState>(ProductDetailMiddleware(repository)),
        EpicMiddleware<AppState>(ActivityMiddleware(repository)),
        EpicMiddleware<AppState>(SearchMiddleware(CatalogApi()))
      ] +
      createFavoriteMiddleware(repository);
}
