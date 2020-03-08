import 'package:lightingPalazzoli/data/local/datasources/catalog_datasource.dart';
import 'package:lightingPalazzoli/data/network/catalog_api.dart';
import 'package:lightingPalazzoli/models/activity.dart';
import 'package:lightingPalazzoli/models/app_config.dart';
import 'package:lightingPalazzoli/models/catalog.dart';
import 'package:lightingPalazzoli/models/category.dart';
import 'package:lightingPalazzoli/models/favorite_product.dart';
import 'package:lightingPalazzoli/models/product.dart';
import 'package:lightingPalazzoli/models/product_detail.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';

class Repository {
  static Repository _singleton = Repository._();

  final CatalogApi _catalogApi = CatalogApi();
  final CatalogDataSource _catalogDataSource = CatalogDataSource();

  Repository._();

  factory Repository() => _singleton;

  Stream<AppConfig> getAppConfig() async* {
    var item = await _catalogDataSource.getAppConfig();
    if (item != null) {
      yield item;
    }

    try {
      var newItemList = await _catalogApi.getAppConfig();
      var newItem = newItemList?.getItem();
      if (item != newItem) {
        _catalogDataSource.insertAppConfig(newItem);
        yield newItem;
      }
    } catch (e) {
      if (item == null) throw e;
    }
  }

  Stream<List<Catalog>> getCatalogs() async* {
    var list = await _catalogDataSource.getCatalogs();

    if (list != null) {
      yield list.items;
    }
    try {
      var newList = await _catalogApi.getCatalogs();
      if (list != newList) {
        _catalogDataSource.insertCatalogs(newList);
        yield newList.items;
      }
    } catch (e) {
      if (list == null) throw e;
    }
  }

  Stream<List<Category>> getCategories(int catalogId) async* {
    var list = await _catalogDataSource.getCategories(catalogId);
    if (list != null) {
      yield list.items;
    }

    try {
      var newList = await _catalogApi.getCategories(catalogId);
      if (newList != list) {
        _catalogDataSource.insertCategories(catalogId, newList);
        yield newList.items;
      }
    } catch (e) {
      if (list == null) throw e;
    }
  }

  Stream<List<Subcategory>> getSubcategories(int categoryId) async* {
    var list = await _catalogDataSource.getSubcategories(categoryId);
    if (list != null) {
      yield list.items;
    }

    try {
      var newList = await _catalogApi.getSubcategories(categoryId);
      if (newList != list) {
        _catalogDataSource.insertSubcategory(categoryId, newList);
        yield newList.items;
      }
    } catch (e) {
      if (list == null) throw e;
    }
  }

  Stream<ProductList> getProducts(Subcategory subcategory) async* {
    var list = await _catalogDataSource.getProducts(subcategory.id);
    if (list != null) {
      yield list;
    }

    try {
      var productCodes =
          subcategory.productCodes.split(',').map((t) => t.trim()).toList();
      var type = subcategory.type;
      var attributes =
          subcategory.atribute.split(',').map((t) => t.trim()).toList();
      ProductList newList = await _catalogApi.getProducts(
          productCodes: productCodes, type: type, attributes: attributes);

      if (newList != list) {
        _catalogDataSource.insertProducts(subcategory.id, newList);
        yield newList;
      }
    } catch (e) {
      if (list == null) throw e;
    }
  }

  Stream<ProductDetail> getProductDetail(String id, String type) async* {
    var productDetail = await _catalogDataSource.getProductDetail(id, type);
    if (productDetail != null) {
      yield productDetail;
    }

    try {
      var newProductDetailList =
          await _catalogApi.getProductDetail(id: id, type: type);
      var newProductDetail = newProductDetailList?.getItem();
      if (newProductDetail != productDetail) {
        _catalogDataSource.insertProductDetail(id, type, newProductDetail);
        yield newProductDetail;
      }
    } catch (e) {
      if (productDetail == null) throw e;
    }
  }

  Future<List<FavoriteProduct>> getFavoriteProducts() {
    return _catalogDataSource.getFavoriteProducts().then((list) => list.items);
  }

  Future<void> saveFavoriteProducts(List<FavoriteProduct> favoriteProducts) {
    return _catalogDataSource
        .insertFavoriteProducts(FavoriteProductList(items: favoriteProducts));
  }

  Stream<ActivityList> getActivities() async* {
    var list = await _catalogDataSource.getActivities();
    if (list != null) {
      yield list;
    }

    try {
      ActivityList newList = await _catalogApi.getActivities();

      if (newList != list) {
        _catalogDataSource.insertActivities(newList);
        yield newList;
      }
    } catch (e) {
      if (list == null) throw e;
    }
  }
}
