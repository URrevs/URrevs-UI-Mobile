import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/app/app.dart';
import 'package:urrevs_ui_mobile/app/branch_vars.dart';
import 'package:urrevs_ui_mobile/app/dependency_injection.dart';
import 'package:urrevs_ui_mobile/firebase_options.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/translations/codegen_loader.g.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return host == 'urrevs.com';
      };
  }
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    await EasyLocalization.ensureInitialized();
    await initAppModule();

    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    await dotenv.load();

    HttpOverrides.global = MyHttpOverrides();

    runApp(
      EasyLocalization(
        supportedLocales:
            LanguageType.values.map((langType) => langType.locale).toList(),
        startLocale: LanguageType.ar.locale,
        path: AssetsPaths.translations,
        fallbackLocale: LanguageType.en.locale,
        assetLoader: CodegenLoader(),
        child: ProviderScope(child: MyApp(initialLink: initialLink)),
      ),
      // MyApp(),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: false);
  });
}
