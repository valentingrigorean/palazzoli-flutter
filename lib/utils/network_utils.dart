import 'dart:io';

import 'package:connectivity/connectivity.dart';

class NetworkUtils{
  NetworkUtils._();

  static Future<bool> checkConnectivity() async{
    var connection = Connectivity();
    var result = await connection.checkConnectivity();

    if (result != ConnectivityResult.none) {
      if (Platform.isAndroid) {
        return await _checkInternetAndroid();
      }
      return true;
    }
    return false;
  }


  static Future<bool> _checkInternetAndroid() async {
    var hasConnection = true;
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } catch (e) {
      hasConnection = false;
    }
    return hasConnection;
  }
}