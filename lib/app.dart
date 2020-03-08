import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lightingPalazzoli/data/sharedpref/shared_preference_helper.dart';
import 'package:lightingPalazzoli/generated/customMaterial.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/redux/app/app_state.dart';
import 'package:lightingPalazzoli/ui/splash/splash_screen.dart';
import 'package:redux/redux.dart';

import 'app_vm.dart';
import 'generated/i18n.dart';

typedef ChangeLanguageDelegate = void Function(Locale locale);

ChangeLanguageDelegate kChangeLanguageDelegate;

class PalazzoliApp extends StatefulWidget {
  final Store<AppState> store;
  final Locale locale;

  const PalazzoliApp({Key key, this.store, this.locale}) : super(key: key);

  @override
  _PalazzoliAppState createState() => _PalazzoliAppState();
}

class _PalazzoliAppState extends State<PalazzoliApp> {
  SpecifiedLocalizationDelegate _localeOverrideDelegate;
  SpecifiedMaterialLocalizationDelegate _localeOverrideMaterialDelegate;

  @override
  void initState() {
    super.initState();
    kChangeLanguageDelegate = _onChangeLanguage;
    _localeOverrideDelegate = SpecifiedLocalizationDelegate(widget.locale);
    _localeOverrideMaterialDelegate =
        SpecifiedMaterialLocalizationDelegate(widget.locale);
  }

  @override
  void dispose() {
    kChangeLanguageDelegate = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: StoreConnector<AppState, AppViewModel>(
        converter: (store) => AppViewModel.fromStore(store),
        distinct: true,
        builder: (context, vm) {
          return PalazzoliTheme(
            data: vm.themeData.copyWith(appBarColor: Colors.red),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Catalogo Lighting',
              theme: vm.themeData.toThemeData(),
              localizationsDelegates: [
                _localeOverrideDelegate,
                S.delegate,
                GlobalCupertinoLocalizations.delegate,
                _localeOverrideMaterialDelegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              localeResolutionCallback: S.delegate.resolution(
                fallback: _localeOverrideDelegate.overriddenLocale,
              ),
              home: SplashScreen(),
            ),
          );
        },
      ),
    );
  }

  void _onChangeLanguage(Locale locale) async {
    await SharedPreferenceHelper().saveLanguage(locale);
    setState(() {
      _localeOverrideDelegate = SpecifiedLocalizationDelegate(locale);
      _localeOverrideMaterialDelegate =
          SpecifiedMaterialLocalizationDelegate(locale);
    });
  }
}

class SpecifiedMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  //class static vars:
  //onLocaleChange should be bind to MaterialApp function containing setState().

  // for instance
  final Locale overriddenLocale;

  const SpecifiedMaterialLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      CustomMaterialLocalizations.delegate.load(overriddenLocale);

  @override
  bool shouldReload(SpecifiedMaterialLocalizationDelegate old) => true;
}

class SpecifiedLocalizationDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  //class static vars:
  //onLocaleChange should be bind to MaterialApp function containing setState().

  // for instance
  final Locale overriddenLocale;

  const SpecifiedLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<WidgetsLocalizations> load(Locale locale) =>
      S.delegate.load(overriddenLocale);

  @override
  bool shouldReload(SpecifiedLocalizationDelegate old) => true;
}
