import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/models/category.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_actions.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_item_widget.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_list_with_header_widget.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_subcategory_vm.dart';
import 'package:lightingPalazzoli/ui/tab_content_widget.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';
import 'package:lightingPalazzoli/widgets/custom_image_widget.dart';
import 'package:quiver/strings.dart';

class CatalogSubcategoryScreen extends StatelessWidget {
  final int categoryId;

  const CatalogSubcategoryScreen({Key key, @required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = PalazzoliTheme.of(context);
    var textStyle = theme.textTheme.body1.copyWith(
        fontSize: 14, fontWeight: FontWeight.w600, color: theme.titleItemColor);
    var iconColor = theme.iconColor;

    return TabContentWidget(
      child: ContentWidget<SubcategoryViewModel>(
        dispatchAction: LoadSubcategoryAction(categoryId),
        converter: (store) => SubcategoryViewModel.fromStore(store, context),
        viewModelBuilder: (context, vm) {
          return CatalogListWithHeaderWidget(
            header: _buildHeader(context, vm.category),
            itemCount: vm.items.length,
            itemBuilder: (context, index) {
              var item = vm.items[index];
              var title = isBlank(item.name) ? item.body : item.name;
              return Material(
                color: Colors.transparent,
                child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(title, style: textStyle),
                    ),
                    onTap: () => vm.onTap(item),
                    leading: CustomImageWidget(
                      url: item?.image ?? '',
                      width: 66,
                      height: 55,
                      fit: BoxFit.fill,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: iconColor,
                    )),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Category category) {
    var theme = PalazzoliTheme.of(context);
    return CatalogItemWidget(
        item: CatalogItem.fromCategory(category),
        titleColor: theme.titleHeaderColor,
        subtitleColor: theme.subtitleHeaderColor,
        decoration: (context, child) => Container(
              color: theme.backgroundHeaderColor,
              child: child,
            ));
  }
}
