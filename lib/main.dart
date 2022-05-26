import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/app/app.dart';
import 'package:urrevs_ui_mobile/app/dependency_injection.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await initAppModule();

  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

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
}
