import 'package:lightingPalazzoli/redux/favorite/favorite_actions.dart';
import 'package:lightingPalazzoli/redux/favorite/favorite_state.dart';
import 'package:redux/redux.dart';

final favoriteReducer = combineReducers<FavoriteState>([
  TypedReducer<FavoriteState, LoadedFavoriteAction>(_onLoaded),
  TypedReducer<FavoriteState, AddFavoriteAction>(_onAddProduct),
  TypedReducer<FavoriteState, DeleteFavoriteAction>(_onDeleteProduct),
]);

FavoriteState _onLoaded(FavoriteState state, LoadedFavoriteAction action) {
  return FavoriteState(items: action.items);
}

FavoriteState _onAddProduct(FavoriteState state, AddFavoriteAction action) {
  return FavoriteState(
      items: List.from(state.items)..add(action.favoriteProduct));
}

FavoriteState _onDeleteProduct(
    FavoriteState state, DeleteFavoriteAction action) {
  return FavoriteState(
      items: state.items
          .where((fav) =>
              fav.productId != action.favoriteProduct.productId &&
              fav.subcategory.type != action.favoriteProduct.subcategory.type)
          .toList());
}
