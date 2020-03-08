import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lightingPalazzoli/data/network/constants/endpoints.dart';
import 'package:lightingPalazzoli/data/network/dio_client.dart';
import 'package:lightingPalazzoli/models/activity.dart';
import 'package:lightingPalazzoli/models/app_config.dart';
import 'package:lightingPalazzoli/models/catalog.dart';
import 'package:lightingPalazzoli/models/category.dart';
import 'package:lightingPalazzoli/models/mail_info.dart';
import 'package:lightingPalazzoli/models/product.dart';
import 'package:lightingPalazzoli/models/product_detail.dart';
import 'package:lightingPalazzoli/models/register.dart';
import 'package:lightingPalazzoli/models/search_result.dart';
import 'package:lightingPalazzoli/models/subcategory.dart';
import 'package:meta/meta.dart';

class CatalogApi {
  static final CatalogApi _singleton = CatalogApi._();
  final DioClient _dioClient = DioClient();

  CatalogApi._();

  factory CatalogApi() => _singleton;

  Future<AppConfigList> getAppConfig() {
    return _dioClient
        .get(Endpoints.getConfig)
        .then((json) => AppConfigList.fromJson(json));
  }

  Future<CatalogList> getCatalogs() {
    return _dioClient
        .get(Endpoints.getCatalog)
        .then((json) => CatalogList.fromJson(json));
  }

  Future<CategoryList> getCategories(int catalogId) {
    return _dioClient
        .get(Endpoints.getCategories + '/$catalogId')
        .then((json) => CategoryList.fromJson(json));
  }

  Future<SubcategoryList> getSubcategories(int categoryId) {
    return _dioClient
        .get(Endpoints.getSubcategories + '/$categoryId')
        .then((json) => SubcategoryList.fromJson(json));
  }

  Future<ProductList> getProducts(
      {@required List<String> productCodes,
      @required String type,
      @required List<String> attributes}) {
    return _dioClient
        .post(
            Endpoints.getProducts,
            jsonEncode({
              'product_codes': productCodes,
              'type': type,
              'atribute': attributes
            }))
        .then((json) => _getProductFromJson(json));
  }

  Future<ProductDetailList> getProductDetail(
      {@required String id, @required String type}) {
    return _dioClient
        .post(Endpoints.getProductDetail,
            jsonEncode({'product_code': id, 'type': type}))
        .then((json) => ProductDetailList.fromJson(json));
  }

  Future<bool> sendMail(MailInfo info) {
    return _dioClient.post(Endpoints.sendMail, info).then((response) {
      return true;
    });
  }

  Future<ActivityList> getActivities() {
    return _dioClient
        .get(Endpoints.getActivities)
        .then((json) => ActivityList.fromJson(json));
  }

  Future<bool> saveInfo(Register info) {
    return _dioClient.post(Endpoints.saveInfo, info).then((response) {
      return true;
    });
  }

  Future<SearchResultList> searchProducts(String query, int page,
      {int itemPerPage = 15, CancelToken cancelToken}) {
    return _dioClient.post(Endpoints.searchProducts, {
      'search': query,
      'items': itemPerPage.toString(),
      'page': page
    }).then((json) {
      return SearchResultList.fromJson(json);
    });
  }

  static ProductList _getProductFromJson(Map<String, dynamic> json) {
    var data = json['items'] as List;
    if (data.length == 1) {
      json = data[0];
    }

    var keys = json.keys.toList();
    var products = <Product>[];
    var headers = <String>[];
    for (var key in keys) {
      var product = json[key] as Map<String, dynamic>;

      if (headers.isEmpty) {
        headers.addAll(product.keys);
      }
      var map = Map<String, String>();

      for (var header in headers) {
        map[header] = product[header].toString();
      }
      products.add(Product(id: key, properties: map));
    }
    return ProductList(headers: headers, items: products);
  }
}
