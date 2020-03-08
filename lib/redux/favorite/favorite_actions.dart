import 'package:lightingPalazzoli/models/favorite_product.dart';

class LoadFavoriteAction {}

class LoadedFavoriteAction {
  final List<FavoriteProduct> items;

  LoadedFavoriteAction(this.items);
}

class SaveFavoriteAction {}

class AddFavoriteAction extends SaveFavoriteAction {
  final FavoriteProduct favoriteProduct;

  AddFavoriteAction(this.favoriteProduct);
}

class DeleteFavoriteAction extends SaveFavoriteAction {
  final FavoriteProduct favoriteProduct;

  DeleteFavoriteAction(this.favoriteProduct);
}
