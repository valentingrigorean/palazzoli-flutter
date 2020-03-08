import 'package:lightingPalazzoli/models/favorite_product.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';

bool isFavoriteSelector(String id, String type, AppState state) {
  var list = state.favoriteState?.items ?? [];
  return list.firstWhere(
          (fav) => fav.subcategory.type == type && fav.productId == id,
          orElse: () => null) !=
      null;
}

List<FavoriteProduct> favoriteProductsSelector(AppState state) =>
    state.favoriteState?.items ?? [];
