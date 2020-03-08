import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/models/product.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_actions.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_item_widget.dart';
import 'package:lightingPalazzoli/ui/catalog/product/product_list_vm.dart';
import 'package:lightingPalazzoli/ui/tab_content_widget.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';

class ProductListScreen extends StatelessWidget {
  final Subcategory subcategory;

  const ProductListScreen({Key key, @required this.subcategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabContentWidget(
      child: ContentWidget<ProductListViewModel>(
          dispatchAction: LoadProductAction(subcategory),
          converter: (store) => ProductListViewModel.fromStore(store, context),
          viewModelBuilder: (context, vm) {
            return Column(
              children: <Widget>[
                CatalogItemWidget(
                  item: CatalogItem.fromSubcategory(vm.subcategory),
                ),
                _buildTable(context, vm),
              ],
              mainAxisSize: MainAxisSize.max,
            );
          }),
    );
  }

  Widget _buildTable(BuildContext context, ProductListViewModel viewModel) {
    var theme = PalazzoliTheme.of(context);
    var headerStyle = theme.textTheme.body1.copyWith(
        fontSize: 14, fontWeight: FontWeight.w600, color: theme.appBarColor);
    var valueStyle = headerStyle.copyWith(
        fontWeight: FontWeight.normal, color: theme.titleItemColor);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(bottom: 12),
        child: Card(
          color: PalazzoliTheme.of(context).backgroundItemColor,
          elevation: 4,
          margin: const EdgeInsets.only(left: 16, top: 12, right: 16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildItem(values: viewModel.headers, textStyle: headerStyle),
                Divider(
                  height: 1,
                ),
                Flexible(
                  child: ListView(
                    children: (_buildItems(
                            context, viewModel.items, valueStyle, viewModel) +
                        [
                          const SizedBox(
                            height: 8,
                          )
                        ]),
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context, List<Product> items,
      TextStyle textStyle, ProductListViewModel viewModel) {
    var list = List<Widget>();
    for (var item in items) {
      list.add(InkWell(
        onTap: () => viewModel.onTap(item),
        child: _buildItem(
          values: item.properties.values.toList(),
          textStyle: textStyle,
        ),
      ));
      list.add(Divider(
        height: 1,
      ));
    }
    if (list.isNotEmpty) list.removeLast();
    return list;
  }

  Widget _buildItem(
      {List<String> values, TextStyle textStyle, Decoration decoration}) {
    var children = <Widget>[];

    for (var i = 0; i < values.length; i++) {
      children.add(Expanded(child: _buildRow(values[i], textStyle)));
    }

    if (children.isEmpty) return Container();
    return Row(children: children);
  }

  Widget _buildRow(String text, TextStyle style) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 40),
      child:
          Center(child: Text(text, textAlign: TextAlign.center, style: style)),
    );
  }
}
