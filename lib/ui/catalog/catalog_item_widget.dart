import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/models/catalog.dart';
import 'package:lightingPalazzoli/models/category.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/widgets/custom_image_widget.dart';

typedef OnCatalogItemTap = Function(dynamic item);
typedef ItemDecoration = Widget Function(BuildContext context, Widget child);

class CatalogItem {
  final String image;
  final String title;
  final String desc;
  final dynamic item;

  CatalogItem(this.image, this.title, this.desc, this.item);

  factory CatalogItem.fromCatalog(Catalog catalog) {
    return CatalogItem(
        catalog?.image, catalog?.name ?? '', catalog?.body ?? '', catalog);
  }

  factory CatalogItem.fromCategory(Category category) {
    return CatalogItem(category?.image ?? '', category?.title ?? '',
        category?.body ?? '', category);
  }

  factory CatalogItem.fromSubcategory(Subcategory subcategory) {
    return CatalogItem(
        subcategory?.image, subcategory?.body ?? '', '', subcategory);
  }
}

class CatalogItemWidget<T> extends StatelessWidget {
  final CatalogItem item;
  final OnCatalogItemTap onTap;
  final ItemDecoration decoration;
  final Color titleColor;
  final Color subtitleColor;
  final bool isFavorite;

  const CatalogItemWidget(
      {Key key,
      @required this.item,
      this.onTap,
      this.decoration = _defaultDecoration,
      this.titleColor,
      this.subtitleColor,
      this.isFavorite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = PalazzoliTheme.of(context);
    var titleStyle = PalazzoliTheme.of(context).textTheme.title.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w900,
        color: titleColor ?? theme.titleItemColor);
    var descStyle = titleStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: subtitleColor ?? theme.subtitleItemColor);

    var child = InkWell(
        onTap: onTap == null
            ? null
            : () {
                onTap(item.item);
              },
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              child: CustomImageWidget(
                url: item?.image ?? '',
                width: 66,
                height: 55,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(item.title, style: titleStyle),
                  const SizedBox(height: 7),
                  Text(item.desc, style: descStyle)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: isFavorite
                  ? Icon(Icons.favorite,
                      color: PalazzoliTheme.of(context).iconColor)
                  : SizedBox(),
            ),
          ],
        ));

    return decoration(
        context, Material(color: Colors.transparent, child: child));
  }

  static Widget _defaultDecoration(BuildContext context, Widget child) {
    return Card(
        elevation: 4,
        color: PalazzoliTheme.of(context).backgroundItemColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        margin: const EdgeInsets.only(left: 16, top: 12, right: 16),
        child: child);
  }
}
