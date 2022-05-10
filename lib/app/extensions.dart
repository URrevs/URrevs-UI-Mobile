import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/cupertino.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';

extension IsArabic on BuildContext {
  bool get isArabic => LanguageType.ar.name == locale.languageCode;

  TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;
}

extension IsDarkMode on BuildContext {
  bool get isDarkMode => MediaQuery.of(this).platformBrightness == Brightness.dark;
}
