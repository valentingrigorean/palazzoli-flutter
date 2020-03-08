import 'package:lightingPalazzoli/data/repository.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/app/base_midleware.dart';
import 'package:lightingPalazzoli/redux/favorite/favorite_actions.dart';
import 'package:lightingPalazzoli/selectors/favorite_selector.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

List<Middleware<AppState>> createFavoriteMiddleware(Repository repository) {
  return [
    EpicMiddleware<AppState>(_FavoriteMiddleware(repository)),
    _createSaveFavorite(repository)
  ];
}

class _FavoriteMiddleware extends BaseMiddleware<LoadFavoriteAction> {
  _FavoriteMiddleware(Repository repository) : super(repository);

  @override
  Stream fetchData(AppState state, LoadFavoriteAction action) async* {
    var data = await repository.getFavoriteProducts();
    yield LoadedFavoriteAction(data);
  }
}

Middleware<AppState> _createSaveFavorite(Repository repository) {
  return (store, action, next) {
    next(action);
    if (action is SaveFavoriteAction) {
      repository.saveFavoriteProducts(favoriteProductsSelector(store.state));
    }
  };
}
