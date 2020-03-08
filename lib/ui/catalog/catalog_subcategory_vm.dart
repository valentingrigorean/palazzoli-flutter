import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/models/category.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_actions.dart';
import 'package:lightingPalazzoli/routes.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';
import 'package:redux/redux.dart';

class SubcategoryViewModel extends BaseViewModel {
  final Category category;
  final List<Subcategory> items;
  final Function(Subcategory item) onTap;

  SubcategoryViewModel({this.category, this.items = const [], this.onTap})
      : super(props: [category, items]);

  factory SubcategoryViewModel.fromStore(
      Store<AppState> store, BuildContext context) {
    var appState = store.state;

    return SubcategoryViewModel(
        category: appState.catalogState.selectedCategory,
        items: appState.catalogState.subcategories ?? [],
        onTap: (item) {
          store.dispatch(SelectSubcategoryAction(item));
          Navigator.of(context)
              .pushNamed(Routes.catalogProducts, arguments: item);
        });
  }
}
