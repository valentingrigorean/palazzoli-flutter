import 'dart:ui';

import 'package:lightingPalazzoli/data/sharedpref/constants/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // singleton object
  static final SharedPreferenceHelper _singleton = SharedPreferenceHelper._();

  // A private constructor. Allows us to create instances of SharedPreferenceHelper
  // only from within the SharedPreferenceHelper class itself.
  SharedPreferenceHelper._();

  // factory method to return the same object each time its needed
  factory SharedPreferenceHelper() => _singleton;

  // Singleton accessor
  static SharedPreferenceHelper get instance => _singleton;

  // General Methods: ----------------------------------------------------------
  Future<Locale> get currentLanguage async {
    var prefs = await SharedPreferences.getInstance();
    return Locale(prefs.getString(Preferences.current_language) ?? 'it');
  }

  Future<bool> get hasCurrentLanguage async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Preferences.has_register_data) ?? false;
  }

  Future<void> saveLanguage(Locale locale) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(Preferences.current_language, locale.languageCode);
  }

  Future<bool> get hasRegisterData async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Preferences.has_register_data) ?? false;
  }

  Future<void> setHasRegisterData(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(Preferences.has_register_data, value);
  }
}
