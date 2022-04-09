import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/app/app.dart';
import 'package:urrevs_ui_mobile/app/dependency_injection.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();

  runApp(
    EasyLocalization(
      supportedLocales:
          LanguageType.values.map((langType) => langType.locale).toList(),
      path: AssetsPaths.translations,
      fallbackLocale: LanguageType.en.locale,
      assetLoader: CodegenLoader(),
      child: ProviderScope(child: MyApp()),
    ),
    // MyApp(),
  );
}
