import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/models/catalog.dart';
import 'package:lightingPalazzoli/models/category.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_actions.dart';
import 'package:lightingPalazzoli/routes.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';
import 'package:redux/redux.dart';

class CategoryViewModel extends BaseViewModel {
  final Catalog catalog;
  final List<Category> categories;
  final Function(Category item) onTap;

  CategoryViewModel({this.catalog, this.categories, this.onTap})
      : super(props: [catalog, categories]);

  factory CategoryViewModel.fromStore(
      Store<AppState> store, BuildContext context) {
    var state = store.state.catalogState;
    return CategoryViewModel(
        catalog: state.selectedCatalog,
        categories: state.categories ?? [],
        onTap: (item) {
          store.dispatch(SelectCategoryAction(item));
          Navigator.of(context).pushNamed(Routes.catalogSubcategory);
        });
  }
}
