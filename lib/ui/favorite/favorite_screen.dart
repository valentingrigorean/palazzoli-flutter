import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_item_widget.dart';
import 'package:lightingPalazzoli/ui/favorite/favorite_vm.dart';
import 'package:lightingPalazzoli/ui/tab_content_widget.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentWidget<FavoriteViewModel>(
      converter: (store) => FavoriteViewModel.fromStore(store, context),
      viewModelBuilder: (context, vm) => _buildContent(vm),
    );
  }

  Widget _buildContent(FavoriteViewModel vm) {
    var items = vm.items;
    return TabContentWidget(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return Dismissible(
                key: ValueKey(item),
                background: Card(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  margin: const EdgeInsets.only(left: 16, top: 12, right: 16),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => vm.onDelete(item),
                child: CatalogItemWidget(
                    item: CatalogItem.fromSubcategory(item.subcategory),
                    onTap: (_) => vm.onTap(item),
                    isFavorite: true),
              );
            }));
  }
}
