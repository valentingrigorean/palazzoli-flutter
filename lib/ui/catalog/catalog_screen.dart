import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_actions.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_item_widget.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_vm.dart';
import 'package:lightingPalazzoli/ui/tab_content_widget.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabContentWidget(
        child: ContentWidget<CatalogViewModel>(
            dispatchAction: LoadCatalogsAction(),
            converter: (store) => CatalogViewModel.fromStore(store, context),
            viewModelBuilder: (context, vm) {
              var items = vm.items;
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return CatalogItemWidget(
                        item: CatalogItem.fromCatalog(items[index]),
                        onTap: (item) => vm.onTap(item));
                  });
            }));
  }
}
