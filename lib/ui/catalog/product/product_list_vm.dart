import 'package:flutter/cupertino.dart';
import 'package:lightingPalazzoli/models/product.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_actions.dart';
import 'package:lightingPalazzoli/routes.dart';
import 'package:lightingPalazzoli/ui/catalog/product/product_detail_screen.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';
import 'package:redux/redux.dart';

class ProductListViewModel extends BaseViewModel {
  final Subcategory subcategory;
  final List<Product> items;
  final List<String> headers;
  final Function(Product item) onTap;

  ProductListViewModel({this.subcategory, this.items, this.headers, this.onTap})
      : super(props: [subcategory, items, headers]);

  factory ProductListViewModel.fromStore(
      Store<AppState> store, BuildContext context) {
    var appState = store.state;
    var state = appState.catalogState;

    return ProductListViewModel(
        subcategory: state.selectedSubcategory,
        headers: state.products?.headers ?? [],
        items: state.products?.items ?? [],
        onTap: (item) {
          store.dispatch(SelectProductAction(item));
          Navigator.of(context).pushNamed(Routes.catalogProductDetail,
              arguments: ProductDetailScreenData(
                  id: item.id, type: state.selectedSubcategory.type));
        });
  }
}
