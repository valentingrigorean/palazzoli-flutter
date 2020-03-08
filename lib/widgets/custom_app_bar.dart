import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lightingPalazzoli/app.dart';
import 'package:lightingPalazzoli/data/sharedpref/shared_preference_helper.dart';
import 'package:lightingPalazzoli/keys.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/redux/app/app_actions.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/widgets/product_search_delegate.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  final bool showSearchAction;

  CustomAppBar({Key key, this.bottom, this.showSearchAction = true})
      : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    var theme = PalazzoliTheme.of(context);
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    var leading = canPop
        ? IconButton(
            icon: useCloseButton ? const Icon(Icons.close) : BackButtonIcon(),
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            onPressed: () {
              var store = StoreProvider.of<AppState>(context);
              if (store.state.isLoading) store.dispatch(StopLoadingAction());
              if (store.state.hasError) store.dispatch(ClearErrorAction());
              Navigator.maybePop(context);
            },
          )
        : SizedBox();

    return AppBar(
      leading: leading,
      title: CachedNetworkImage(
        imageUrl: theme.logo,
      ),
      centerTitle: true,
      elevation: 0,
      actions: useCloseButton
          ? []
          : [
              showSearchAction
                  ? _CircleButton.fromIcon(
                      iconData: Icons.search,
                      onTap: () => _showSearch(context),
                    )
                  : const SizedBox(width: 1),
              const SizedBox(width: 12),
              _getFlagButton(context),
              const SizedBox(width: 16),
            ],
    );
  }

  Widget _getFlagButton(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferenceHelper().currentLanguage,
        builder: (context, snapshot) {
          var locale = snapshot.data?.languageCode ?? 'it';
          var image = AssetImage(locale == 'en'
              ? 'assets/images/ic_england.png'
              : 'assets/images/ic_italy.png');
          return _CircleButton.fromImage(
              image: image,
              onTap: () {
                kChangeLanguageDelegate(
                    locale == 'en' ? Locale('it') : Locale('en'));
              });
        });
  }

  void _showSearch(BuildContext context) async {
    var item = await showSearch(
        context: PalazzoliKeys.bottomNavigationKey.currentContext,
        delegate: ProductSearchDelegate());

    if (item != null) {
      PalazzoliKeys.bottomNavigationKey.currentState
          .navigateToSubcategory(item);
    }
  }
}

class _CircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _CircleButton({Key key, this.onTap, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
          width: 27,
          height: 27,
          padding: const EdgeInsets.all(0),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          alignment: Alignment.center,
          child: child),
    );
  }

  factory _CircleButton.fromIcon(
      {@required IconData iconData, VoidCallback onTap}) {
    return _CircleButton(
      child: Builder(builder: (context) {
        var theme = PalazzoliTheme.of(context);
        //TODO(vali) : change back to AppBarColor
        return Icon(iconData, color: theme.iconColor, size: 20.5);
      }),
      onTap: onTap,
    );
  }

  factory _CircleButton.fromImage(
      {@required ImageProvider image, VoidCallback onTap}) {
    return _CircleButton(
      child: Image(image: image, width: 20.5, height: 20.5),
      onTap: onTap,
    );
  }
}
