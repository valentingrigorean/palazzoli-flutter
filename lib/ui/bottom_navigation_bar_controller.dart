import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lightingPalazzoli/data/sharedpref/shared_preference_helper.dart';
import 'package:lightingPalazzoli/generated/i18n.dart';
import 'package:lightingPalazzoli/keys.dart';
import 'package:lightingPalazzoli/models/app_tabs.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/palazzoli_theme_data.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/redux/catalog/catalog_actions.dart';
import 'package:lightingPalazzoli/redux/search/search_actions.dart';
import 'package:lightingPalazzoli/routes.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_screen.dart';
import 'package:lightingPalazzoli/ui/catalog/product/product_list_screen.dart';
import 'package:lightingPalazzoli/ui/home/home_screen.dart';
import 'package:lightingPalazzoli/ui/info/info_screen.dart';
import 'package:lightingPalazzoli/widgets/custom_navigation.dart';
import 'package:lightingPalazzoli/widgets/no_animation_route.dart';

class BottomNavigationBarController extends StatefulWidget {
  const BottomNavigationBarController({Key key}) : super(key: key);

  @override
  BottomNavigationBarControllerState createState() =>
      BottomNavigationBarControllerState();
}

class BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  final CupertinoTabController _cupertinoTabController =
      CupertinoTabController();

  Locale _currentLanguage;
  AppTab _currentTab = AppTab.Home;

  void selectTab(AppTab tab) {
    if (_currentTab == tab) return;
    _currentTab = tab;
    _cupertinoTabController.index = getIntFromAppTab(tab);
  }

  void navigateToSubcategory(Subcategory subcategory) {
    selectTab(AppTab.Catalog);

    Future.delayed(Duration(milliseconds: 250)).then((_) {
      var state = PalazzoliKeys.catalogNavigatorKey.currentState;
      var productList = ProductListScreen(
        subcategory: subcategory,
      );
      var store = StoreProvider.of<AppState>(context);
      store.dispatch(ClearSearchAction());
      store.dispatch(SelectSubcategoryAction(subcategory));
      state.pushAndRemoveUntil(
          NoAnimationRoute(builder: (context) => productList),
          (route) => route.settings.name == '/');
    });
  }

  @override
  void dispose() {
    _cupertinoTabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SharedPreferenceHelper.instance.currentLanguage.then(_onLanguageChange);
  }

  @override
  void didUpdateWidget(BottomNavigationBarController oldWidget) {
    super.didUpdateWidget(oldWidget);
    SharedPreferenceHelper.instance.currentLanguage.then(_onLanguageChange);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _cupertinoTabController,
      backgroundColor: PalazzoliTheme.of(context).backgroundColor,
      tabBar: _buildBottomNavigationBar(context),
      tabBuilder: (context, index) =>
          _buildTabPages(context, getAppTabFromInt(index)),
    );
  }

  Widget _buildTabPages(BuildContext context, AppTab tab) {
    switch (tab) {
      case AppTab.Home:
        return HomeScreen(
          onSelectTab: selectTab,
        );
      case AppTab.Catalog:
        return CustomNavigation(
            navigatorKey: PalazzoliKeys.catalogNavigatorKey,
            onGenerateRoute: Routes.buildCatalogRoute());
      case AppTab.Favorite:
        return CustomNavigation(
            navigatorKey: PalazzoliKeys.favoriteNavigatorKey,
            onGenerateRoute: Routes.buildFavoriteRoute());
      case AppTab.Info:
        return InfoScreen();
      default:
        throw 'Not implemented';
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    var localization = S.of(context);
    var theme = PalazzoliTheme.of(context);
    return CupertinoTabBar(
      backgroundColor: theme.backgroundTabBarColor,
      activeColor: theme.selectedTabBarColor,
      inactiveColor: theme.unselectedTabBarColor,
      currentIndex: getIntFromAppTab(_currentTab),
      onTap: (index) => selectTab(getAppTabFromInt(index)),
      items: [
        _buildBottomNavigationBarItem(
            Icons.home, localization.home_nav_bottom_home, theme),
        _buildBottomNavigationBarItem(FontAwesomeIcons.table,
            localization.home_nav_bottom_catalog, theme),
        _buildBottomNavigationBarItem(
            Icons.favorite, localization.home_nav_bottom_fav, theme),
        _buildBottomNavigationBarItem(
            FontAwesomeIcons.info, localization.home_nav_bottom_info, theme)
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData icon, String text, PalazzoliThemeData theme) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: theme.unselectedTabBarColor,
        ),
        title: Text(text),
        activeIcon: Icon(
          icon,
          color: theme.selectedTabBarColor,
        ));
  }

  void _onLanguageChange(Locale locale) {
    if (_currentLanguage == null) {
      _currentLanguage = locale;
      return;
    }

    if (_currentLanguage == locale) {
      return;
    }

    _currentLanguage = locale;

    if (PalazzoliKeys.catalogNavigatorKey.currentState != null) {
      PalazzoliKeys.catalogNavigatorKey.currentState.pushAndRemoveUntil(
          NoAnimationRoute(builder: (context) => CatalogScreen()),
          (_) => false);
    }
  }
}
