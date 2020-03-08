import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/models/catalog.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_actions.dart';
import 'package:lightingPalazzoli/routes.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';
import 'package:redux/redux.dart';

class CatalogViewModel extends BaseViewModel {
  final List<Catalog> items;
  final Function(Catalog item) onTap;

  CatalogViewModel({this.items, this.onTap}) : super(props: [items]);

  factory CatalogViewModel.fromStore(
      Store<AppState> store, BuildContext context) {
    var appState = store.state;
    return CatalogViewModel(
        items: appState.catalogState?.catalogs ?? [],
        onTap: (item) {
          store.dispatch(SelectCatalogAction(item));
          Navigator.of(context)
              .pushNamed(Routes.catalogCategory, arguments: item.id);
        });
  }
}
