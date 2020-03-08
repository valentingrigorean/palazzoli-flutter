import 'dart:convert';

import 'package:lightingPalazzoli/data/local/app_database.dart';
import 'package:lightingPalazzoli/data/local/constants/db_constants.dart';
import 'package:lightingPalazzoli/data/sharedpref/shared_preference_helper.dart';
import 'package:lightingPalazzoli/models/activity.dart';
import 'package:lightingPalazzoli/models/app_config.dart';
import 'package:lightingPalazzoli/models/catalog.dart';
import 'package:lightingPalazzoli/models/category.dart';
import 'package:lightingPalazzoli/models/favorite_product.dart';
import 'package:lightingPalazzoli/models/product.dart';
import 'package:lightingPalazzoli/models/product_detail.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:sembast/sembast.dart';

class CatalogDataSource {
  static final CatalogDataSource _singleton = CatalogDataSource._();

  final _store = StoreRef<String, String>(DBConstants.STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  CatalogDataSource._();

  factory CatalogDataSource() => _singleton;

  Future<void> insertAppConfig(AppConfig appConfig) {
    return _insertJson(DBConstants.APP_CONFIG_KEY, appConfig.toJson(),
        useLanguageKey: false);
  }

  Future<AppConfig> getAppConfig() {
    return _getItemByKey(DBConstants.APP_CONFIG_KEY, useLanguageKey: false)
        .then((json) => json == null ? null : AppConfig.fromJson(json));
  }

  Future<void> insertCatalogs(CatalogList catalog) {
    return _insertJson(DBConstants.CATALOG_KEY, catalog.toJson());
  }

  Future<CatalogList> getCatalogs() {
    return _getItemByKey(DBConstants.CATALOG_KEY)
        .then((json) => json == null ? null : CatalogList.fromJson(json));
  }

  Future<void> insertCategories(int catalogId, CategoryList categories) {
    return _insertJson(
        DBConstants.CATEGORY_KEY + "_$catalogId", categories.toJson());
  }

  Future<CategoryList> getCategories(int catalogId) {
    return _getItemByKey(DBConstants.CATEGORY_KEY + "_$catalogId")
        .then((json) => json == null ? null : CategoryList.fromJson(json));
  }

  Future<void> insertSubcategory(
      int categoryId, SubcategoryList subcategories) {
    return _insertJson(
        DBConstants.SUBCATEGORY_KEY + '_$categoryId', subcategories.toJson());
  }

  Future<SubcategoryList> getSubcategories(int categoryId) {
    return _getItemByKey(DBConstants.SUBCATEGORY_KEY + '_$categoryId')
        .then((json) => json == null ? null : SubcategoryList.fromJson(json));
  }

  Future<void> insertProducts(int subcategoryId, ProductList products) {
    return _insertJson(
        DBConstants.PRODUCT_KEY + '_$subcategoryId', products.toJson());
  }

  Future<ProductList> getProducts(int subcategoryId) {
    return _getItemByKey(DBConstants.PRODUCT_KEY + '_$subcategoryId')
        .then((json) => json == null ? null : ProductList.fromJson(json));
  }

  Future<void> insertProductDetail(
      String id, String type, ProductDetail product) {
    var key = DBConstants.PRODUCT_DETAIL_KEY + '_$id\_$type';
    return _insertJson(key, product.toJson());
  }

  Future<ProductDetail> getProductDetail(String id, String type) {
    var key = DBConstants.PRODUCT_DETAIL_KEY + '_$id\_$type';
    return _getItemByKey(key)
        .then((json) => json == null ? null : ProductDetail.fromJson(json));
  }

  Future<void> _insertJson(String key, Map<String, dynamic> json,
      {bool useLanguageKey = true, bool merge = false}) async {
    if (useLanguageKey) {
      key = await _getKey(key);
    }
    try {
      await _store.record(key).put(await _db, jsonEncode(json), merge: merge);
    } catch (e) {
      print(e);
    }
  }

  Future<FavoriteProductList> getFavoriteProducts() {
    var key = DBConstants.FAVORITE_KEY;
    return _getItemByKey(key).then((json) => json == null
        ? FavoriteProductList(items: [])
        : FavoriteProductList.fromJson(json));
  }

  Future<void> insertFavoriteProducts(FavoriteProductList items) {
    var key = DBConstants.FAVORITE_KEY;
    return _insertJson(key, items.toJson());
  }

  Future<void> insertActivities(ActivityList activities) {
    return _insertJson(DBConstants.ACTIVITY_KEY, activities.toJson());
  }

  Future<ActivityList> getActivities() {
    return _getItemByKey(DBConstants.ACTIVITY_KEY)
        .then((json) => json == null ? null : ActivityList.fromJson(json));
  }

  Future<Map<String, dynamic>> _getItemByKey(String key,
      {bool useLanguageKey = true}) async {
    if (useLanguageKey) {
      key = await _getKey(key);
    }
    var finder = Finder(filter: Filter.byKey(key));
    var results = await _store.findFirst(await _db, finder: finder);

    if (results?.value == null) return null;
    return jsonDecode(results.value);
  }

  static Future<String> _getKey(String key) async {
    var locale = await SharedPreferenceHelper().currentLanguage;
    return "${locale.languageCode}_$key";
  }
}
