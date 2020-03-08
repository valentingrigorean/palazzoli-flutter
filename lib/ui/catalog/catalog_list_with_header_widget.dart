import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';

class CatalogListWithHeaderWidget extends StatelessWidget {
  final Widget header;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;

  const CatalogListWithHeaderWidget(
      {Key key, this.header, this.itemBuilder, this.itemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = PalazzoliTheme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.backgroundItemColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: theme.backgroundHeaderColor, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.maxFinite,
            color: theme.backgroundHeaderColor,
            child: header,
          ),
          Flexible(
            child: ListView.separated(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemBuilder: itemBuilder,
                separatorBuilder: (context, index) => const Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: const Divider(
                        height: 1,
                      ),
                    ),
                itemCount: itemCount),
          )
        ],
      ),
    );
  }
}
