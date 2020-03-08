import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lightingPalazzoli/generated/i18n.dart';
import 'package:lightingPalazzoli/models/app_tabs.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/ui/home/home_vm.dart';
import 'package:lightingPalazzoli/ui/tab_content_widget.dart';
import 'package:lightingPalazzoli/widgets/custom_image_widget.dart';

class HomeScreen extends StatelessWidget {
  final ValueSetter<AppTab> onSelectTab;

  const HomeScreen({Key key, @required this.onSelectTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabContentWidget(
      child: Column(children: <Widget>[
        Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: StoreConnector<AppState, HomeViewModel>(
                converter: (store) => HomeViewModel.fromStore(store),
                builder: (context, vm) {
                  return CustomImageWidget(
                    url: vm.mainImage,
                    fit: BoxFit.cover,
                  );
                },
              ),
            )),
        Expanded(child: _buildCatalog(context)),
        Expanded(child: _buildFavAndInfo(context))
      ]),
    );
  }

  Widget _buildCatalog(BuildContext context) {
    var localization = S.of(context);

    var theme = PalazzoliTheme.of(context);

    return Card(
        margin: const EdgeInsets.all(16),
        color: theme.backgroundButtonColor,
        child: InkWell(
          onTap: () => onSelectTab(AppTab.Catalog),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 16,
                bottom: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _TextWithArrow(
                      text: localization.home_catalog.toUpperCase(),
                      textColor: Colors.white,
                      arrowColor: theme.textButtonColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      localization.home_check_out_products,
                      style: theme.textTheme.body1.copyWith(
                          color: theme.textButtonColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 12),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildFavAndInfo(BuildContext context) {
    var localization = S.of(context);
    var theme = PalazzoliTheme.of(context);
    var textColor = theme.textButtonColor;

    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(children: <Widget>[
          Expanded(
              child: _buildCard(
                  localization.home_nav_bottom_fav,
                  textColor,
                  theme.backgroundButtonColor,
                  () => onSelectTab(AppTab.Favorite))),
          const SizedBox(width: 16),
          Expanded(
              child: _buildCard(localization.home_nav_bottom_info, textColor,
                  theme.backgroundButtonColor, () => onSelectTab(AppTab.Info)))
        ]));
  }

  Widget _buildCard(
      String text, Color textColor, Color backgroundColor, VoidCallback onTap) {
    return Card(
        margin: const EdgeInsets.all(0),
        color: backgroundColor,
        child: InkWell(
          onTap: onTap,
          child: Container(
              margin: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: _TextWithArrow(
                  text: text, textColor: textColor, arrowColor: textColor)),
        ));
  }
}

class _TextWithArrow extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color arrowColor;

  const _TextWithArrow({Key key, this.text, this.textColor, this.arrowColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.title.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: textColor ?? Color(0xFF1F1F1F));

    return Row(children: <Widget>[
      Text(text.toUpperCase(), style: textStyle),
      const SizedBox(
        width: 16,
      ),
      Icon(Icons.arrow_forward, color: arrowColor, size: 13)
    ]);
  }
}
