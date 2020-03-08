import 'package:flutter/cupertino.dart';
import 'package:lightingPalazzoli/models/favorite_product.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/favorite/favorite_actions.dart';
import 'package:lightingPalazzoli/routes.dart';
import 'package:lightingPalazzoli/selectors/favorite_selector.dart';
import 'package:lightingPalazzoli/ui/catalog/product/product_detail_screen.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';
import 'package:redux/redux.dart';

class ProductDetailViewModel extends BaseViewModel {
  final String code;
  final String infoBody;
  final Subcategory subcategory;
  final Map<String, String> technicalData;
  final Map<String, String> personalData;
  final List<String> statements;
  final Map<String, String> downloads;

  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onEmail;

  ProductDetailViewModel(
      {this.code,
      this.infoBody,
      this.subcategory,
      this.technicalData,
      this.personalData,
      this.statements,
      this.downloads,
      this.isFavorite = false,
      this.onFavorite,
      this.onEmail})
      : super(props: [
          code,
          infoBody,
          subcategory,
          technicalData,
          personalData,
          statements,
          downloads,
          isFavorite
        ]);

  factory ProductDetailViewModel.fromStore(Store<AppState> store,
      ProductDetailScreenData data, BuildContext context) {
    var state = store.state.catalogState;
    var isFavorite = isFavoriteSelector(data.id, data.type, store.state);
    var subcategory = data.subcategory ?? state.selectedSubcategory;
    var productDetail = state.productDetail;
    return ProductDetailViewModel(
        code: productDetail?.code ?? '',
        infoBody: productDetail?.infoBody ?? '',
        isFavorite: isFavorite,
        subcategory: subcategory,
        technicalData: productDetail?.technicalData ?? {},
        personalData: productDetail?.personalData ?? {},
        statements: productDetail?.statements ?? [],
        downloads: productDetail?.downloads ?? {},
        onFavorite: () {
          var favoriteProduct =
              FavoriteProduct(productId: data.id, subcategory: subcategory);
          if (!isFavorite)
            store.dispatch(AddFavoriteAction(favoriteProduct));
          else
            store.dispatch(DeleteFavoriteAction(favoriteProduct));
        },
        onEmail: () =>
            Navigator.of(context).pushNamed(Routes.info, arguments: data.id));
  }
}
