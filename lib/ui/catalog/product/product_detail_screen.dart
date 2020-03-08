import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lightingPalazzoli/generated/i18n.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_actions.dart';
import 'package:lightingPalazzoli/ui/catalog/product/product_detail_vm.dart';
import 'package:lightingPalazzoli/ui/tab_content_widget.dart';
import 'package:lightingPalazzoli/widgets/content_widget.dart';
import 'package:lightingPalazzoli/widgets/custom_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreenData {
  final String id;
  final String type;
  final Subcategory subcategory;

  ProductDetailScreenData({this.id, this.type, this.subcategory});
}

class ProductDetailScreen extends StatelessWidget {
  final ProductDetailScreenData data;

  const ProductDetailScreen({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabContentWidget(
      child: ContentWidget<ProductDetailViewModel>(
        dispatchAction: LoadProductDetailAction(data.id, data.type),
        converter: (store) =>
            ProductDetailViewModel.fromStore(store, data, context),
        viewModelBuilder: (context, vm) => _buildContent(vm),
      ),
    );
  }

  Widget _buildContent(ProductDetailViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: <Widget>[
          _ProductDetailHeader(
            code: viewModel.code,
            infoBody: viewModel.infoBody,
            subcategory: viewModel.subcategory,
            isFavorite: viewModel.isFavorite,
            onEmail: viewModel.onEmail,
            onFavorite: viewModel.onFavorite,
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(child: _ProductDetailTable(viewModel: viewModel))
        ],
      ),
    );
  }
}

class _ProductDetailHeader extends StatefulWidget {
  final String code;
  final String infoBody;
  final Subcategory subcategory;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onEmail;

  const _ProductDetailHeader(
      {Key key,
      @required this.code,
      @required this.infoBody,
      @required this.subcategory,
      this.isFavorite,
      this.onFavorite,
      this.onEmail})
      : assert(subcategory != null),
        super(key: key);

  @override
  __ProductDetailHeaderState createState() => __ProductDetailHeaderState();
}

class __ProductDetailHeaderState extends State<_ProductDetailHeader> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: PalazzoliTheme.of(context).backgroundItemColor,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(children: <Widget>[
          _buildLeftSide(),
          const SizedBox(
            width: 12,
          ),
          _buildRightSide(context)
        ]),
      ),
    );
  }

  Widget _buildLeftSide() {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: CustomImageWidget(
            url: widget.subcategory?.image ?? '',
            fit: BoxFit.cover,
            width: 120,
            height: 96));
  }

  Widget _buildRightSide(BuildContext context) {
    var theme = PalazzoliTheme.of(context);
    var titleStyle = theme.textTheme.body1.copyWith(
        fontSize: 16, fontWeight: FontWeight.w900, color: theme.titleItemColor);
    var descStyle = titleStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: theme.subtitleItemColor);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.code,
                style: titleStyle,
              ),
              _buildButtons(context),
            ],
          ),
          Text(
            widget.infoBody,
            style: descStyle,
          )
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    var theme = PalazzoliTheme.of(context);
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(widget.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: theme.iconColor),
          alignment: Alignment.centerLeft,
          onPressed: widget.onFavorite,
          padding: const EdgeInsets.all(0),
        ),
        IconButton(
          icon: Icon(Icons.mail, color: theme.iconColor),
          onPressed: widget.onEmail,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(0),
        )
      ],
    );
  }
}

class _ProductDetailTable extends StatelessWidget {
  final ProductDetailViewModel viewModel;

  const _ProductDetailTable({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = PalazzoliTheme.of(context);
    return Card(
      elevation: 4,
      color: theme.backgroundItemColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: _buildWithAllTabs(context),
      ),
    );
  }

  Widget _buildWithAllTabs(BuildContext context) {
    var theme = PalazzoliTheme.of(context);
    return DefaultTabController(
        initialIndex: 0,
        length: 1,
        //length: 4,
        child: Column(
          children: <Widget>[
            _buildTabBar(context),
            Container(
              height: 1,
              color: theme.disabledColor,
              width: double.maxFinite,
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  _TwoValueTable(items: viewModel.technicalData),
                  //TODO(vali): add back when impl on backend
                  //  _TwoValueTable(items: viewModel.personalData),
                  //  _buildStatement(context),
                  // _ProductDownloadLinks(items: viewModel.downloads)
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildTabBar(BuildContext context) {
    var localization = S.of(context);
    var theme = PalazzoliTheme.of(context);
    var labelStyle = theme.textTheme.body1
        .copyWith(fontSize: 12, fontWeight: FontWeight.bold);

    var unselectedLabelStyle = labelStyle.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: theme.unselectedTabBarColor);

    return TabBar(
      isScrollable: true,
      indicatorColor: theme.selectedTabBarColor,
      labelColor: theme.selectedTabBarColor,
      labelStyle: labelStyle,
      unselectedLabelColor: theme.unselectedTabBarColor,
      unselectedLabelStyle: unselectedLabelStyle,
      tabs: <Widget>[
        Tab(
          text: localization.catalog_product_technical_data,
        )
      ],
    );
  }

  // ignore: unused_element
  Widget _buildStatement(BuildContext context) {
    var theme = PalazzoliTheme.of(context);
    var textStyle = theme.textTheme.body1.copyWith(
        fontSize: 12, fontWeight: FontWeight.bold, color: theme.titleItemColor);

    return ListView.separated(
      itemCount: viewModel.statements.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
      ),
      itemBuilder: (context, index) {
        Widget child = Container(
          constraints: BoxConstraints(minHeight: 40),
          alignment: Alignment.center,
          child: Text(
            viewModel.statements[index],
            style: textStyle,
          ),
        );
        return child;
      },
    );
  }
}

class _TwoValueTable extends StatelessWidget {
  final Map<String, String> items;

  const _TwoValueTable({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items == null || items.isEmpty) {
      return SizedBox();
    }
    var hints = items.keys.toList();

    var theme = PalazzoliTheme.of(context);
    var hintStyle = theme.textTheme.body1
        .copyWith(fontSize: 12, color: theme.titleItemColor);

    var valueStyle = hintStyle.copyWith(fontWeight: FontWeight.bold);

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
      ),
      itemBuilder: (context, index) {
        var hint = hints[index];
        return ConstrainedBox(
            constraints: BoxConstraints(minHeight: 40),
            child: Row(
              children: <Widget>[
                Expanded(child: Text(hint, style: hintStyle)),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    items[hint],
                    style: valueStyle,
                  ),
                )
              ],
            ));
      },
    );
  }
}

// ignore: unused_element
class _ProductDownloadLinks extends StatelessWidget {
  final Map<String, String> items;

  const _ProductDownloadLinks({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var keys = items.keys.toList();
    var theme = PalazzoliTheme.of(context);
    var textStyle = theme.textTheme.body1.copyWith(
        fontSize: 12, fontWeight: FontWeight.bold, color: theme.appBarColor);

    return ListView.separated(
        padding: const EdgeInsets.all(0),
        itemCount: items.length,
        separatorBuilder: (context, index) => Divider(
              height: 1,
            ),
        itemBuilder: (context, index) {
          var value = keys[index];
          var link = items[value];
          return InkWell(
            onTap: () => _openLink(link),
            child: Container(
              constraints: BoxConstraints(minHeight: 40),
              alignment: Alignment.center,
              child: Text(
                value,
                style: textStyle,
              ),
            ),
          );
        });
  }

  void _openLink(String url) async {
    if (await canLaunch(url)) {
      try {
        await launch(url);
      } on PlatformException catch (ex) {
        print(ex);
      }
    } else {
      print('failed to open url:$url');
    }
  }
}
