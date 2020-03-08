import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lightingPalazzoli/app.dart';
import 'package:lightingPalazzoli/data/sharedpref/shared_preference_helper.dart';
import 'package:lightingPalazzoli/dsn.dart';
import 'package:lightingPalazzoli/redux/store.dart';
import 'package:sentry/sentry.dart';

bool get isInDebugMode {
  // Assume you're in production mode.
  bool inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);

  return inDebugMode;
}

final SentryClient sentry = SentryClient(dsn: dsn);

void main() {
  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode, simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode, report to the application zone to report to
      // Sentry.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runZoned<Future<void>>(() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    final store = await createStore();
    final locale = await SharedPreferenceHelper().currentLanguage;
    runApp(PalazzoliApp(
      store: store,
      locale: locale,
    ));
  }, onError: (error, stackTrace) {
    // Whenever an error occurs, call the `_reportError` function. This sends
    // Dart errors to the dev console or Sentry depending on the environment.
    reportError(error, stackTrace);
  });
}

Future<void> reportError(dynamic error, dynamic stackTrace) async {
  // Print the exception to the console.
  print('Caught error: $error');
  if (isInDebugMode) {
    // Print the full stacktrace in debug mode.
    print(stackTrace);
  } else {
    // Send the Exception and Stacktrace to Sentry in Production mode.
    sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}
