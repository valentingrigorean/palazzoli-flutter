import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_category_screen.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_screen.dart';
import 'package:lightingPalazzoli/ui/catalog/catalog_subcategory_screen.dart';
import 'package:lightingPalazzoli/ui/catalog/product/product_detail_screen.dart';
import 'package:lightingPalazzoli/ui/catalog/product/product_list_screen.dart';
import 'package:lightingPalazzoli/ui/favorite/favorite_screen.dart';
import 'package:lightingPalazzoli/ui/info/info_screen.dart';

class Routes {
  Routes._();

  static const catalog = '/catalog';
  static const catalogCategory = '/catalog/category';
  static const catalogSubcategory = '/catalog/subcategory';
  static const catalogProducts = '/catalog/subcategory/product';
  static const catalogProductDetail = '/catalog/subcategory/product/detail';
  static const info = '/info';

  static RouteFactory buildCatalogRoute() {
    return (RouteSettings settings) {
      switch (settings.name) {
        case catalogCategory:
          return _buildRoute(
              settings, CatalogCategoryScreen(catalogId: settings.arguments));
        case catalogSubcategory:
          return _buildRoute(settings,
              CatalogSubcategoryScreen(categoryId: settings.arguments));
        case catalogProducts:
          return _buildRoute(
              settings, ProductListScreen(subcategory: settings.arguments));
        case catalogProductDetail:
          return _buildRoute(
              settings, ProductDetailScreen(data: settings.arguments));
        case info:
          return _buildRoute(
              settings, InfoScreen(productCode: settings.arguments));
        default:
          return _buildRoute(settings, CatalogScreen());
      }
    };
  }

  static RouteFactory buildFavoriteRoute() {
    return (RouteSettings settings) {
      switch (settings.name) {
        case catalogProductDetail:
          return _buildRoute(
              settings, ProductDetailScreen(data: settings.arguments));
        case info:
          return _buildRoute(
              settings, InfoScreen(productCode: settings.arguments));
        default:
          return _buildRoute(settings, FavoriteScreen());
      }
    };
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
