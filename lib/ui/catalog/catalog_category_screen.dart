import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/models/catalog.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_actions.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_category_vm.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_item_widget.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_list_with_header_widget.dart';
import 'package:lightingPalazzoli/ui/tab_content_widget.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';

class CatalogCategoryScreen extends StatelessWidget {
  final int catalogId;

  const CatalogCategoryScreen({Key key, @required this.catalogId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabContentWidget(
      child: ContentWidget<CategoryViewModel>(
        dispatchAction: LoadCategoryAction(catalogId),
        converter: (store) => CategoryViewModel.fromStore(store, context),
        viewModelBuilder: (context, vm) {
          return CatalogListWithHeaderWidget(
            header: _buildHeader(context, vm.catalog),
            itemCount: vm.categories.length,
            itemBuilder: (context, index) {
              var item = vm.categories[index];
              return CatalogItemWidget(
                  item: CatalogItem.fromCategory(item),
                  onTap: (item) => vm.onTap(item),
                  decoration: (context, child) => child);
            },
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Catalog catalog) {
    var theme = PalazzoliTheme.of(context);

    var titleStyle = theme.textTheme.body1.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w900,
        color: theme.titleHeaderColor);

    var descStyle = titleStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: theme.subtitleHeaderColor);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            catalog?.name ?? "",
            style: titleStyle,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            catalog?.body ?? "",
            style: descStyle,
          )
        ],
      ),
    );
  }
}
