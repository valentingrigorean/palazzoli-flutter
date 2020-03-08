import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/models/favorite_product.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/favorite/favorite_actions.dart';
import 'package:lightingPalazzoli/routes.dart';
import 'package:lightingPalazzoli/ui/catalog/product/product_detail_screen.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';
import 'package:redux/redux.dart';

class FavoriteViewModel extends BaseViewModel {
  final List<FavoriteProduct> items;
  final Function(FavoriteProduct item) onDelete;
  final Function(FavoriteProduct item) onTap;

  FavoriteViewModel({this.items, this.onDelete, this.onTap})
      : super(props: [items]);

  factory FavoriteViewModel.fromStore(
      Store<AppState> store, BuildContext context) {
    var appState = store.state;

    return FavoriteViewModel(
        items: appState.favoriteState.items ?? [],
        onTap: (item) {
          var args = ProductDetailScreenData(
              id: item.productId,
              type: item.subcategory.type,
              subcategory: item.subcategory);
          Navigator.of(context)
              .pushNamed(Routes.catalogProductDetail, arguments: args);
        },
        onDelete: (item) => store.dispatch(DeleteFavoriteAction(item)));
  }
}
