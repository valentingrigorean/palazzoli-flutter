import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lightingPalazzoli/data/network/constants/endpoints.dart';
import 'package:lightingPalazzoli/data/sharedpref/shared_preference_helper.dart';

Map<String, dynamic> _parseAndDecode(String json) {
  return jsonDecode(json);
}

Future<Map<String, dynamic>> parseJson(String json) {
  return compute(_parseAndDecode, json);
}

class DioClient {
  static final DioClient _singleton = DioClient._();

  final Dio _dio = Dio()
    ..options.baseUrl = Endpoints.baseApiUrl
    ..options.headers = {'Content-Type': 'application/json; charset=utf-8'};

  //..interceptors.add(LogInterceptor(responseBody: true));

  DioClient._() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options) async {
      var language = await SharedPreferenceHelper().currentLanguage;
      options.headers['Accept-Language'] = language.languageCode ?? 'it';
      await _loginIfNeeded(_dio, options);
    }, onResponse: (response) {
      try {
        var data = response.data['data'] as List;
        return {'items': data};
      } catch (e) {
        try {
          return response.data['data'];
        } catch (_e) {
          return response;
        }
      }
    }));

    (_dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  }

  factory DioClient() => _singleton;

  Future<dynamic> get(String uri, {CancelToken cancelToken}) async {
    final response = await _dio.get(uri, cancelToken: cancelToken);
    return response.data;
  }

  Future<dynamic> post(String uri, dynamic data,
      {CancelToken cancelToken}) async {
    final response = await _dio.post(uri, data: data, cancelToken: cancelToken);
    return response.data;
  }

  static Future<void> _loginIfNeeded(Dio dio, RequestOptions options) async {
    if (options.headers.containsKey("Authorization")) {
      return;
    }

    print('Fetching auth token');

    var tokenDio = Dio()
      ..options.baseUrl = Endpoints.baseApiUrl
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'};

    try {
      dio.interceptors.requestLock.lock();

      var response = await tokenDio.post(Endpoints.login,
          data: FormData.from(
              {'email': Endpoints.user, 'password': Endpoints.password}));

      dio.options.headers['Authorization'] =
          "Bearer " + response.data['data'][0]['token'];

      options.headers['Authorization'] =
          "Bearer " + response.data['data'][0]['token'];
    } on DioError catch (e) {
      print('Failed to get auth token:$e');
    } finally {
      dio.interceptors.requestLock.unlock();
    }
  }
}
