import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';

extension IsArabic on BuildContext {
  bool get isArabic => LanguageType.ar.name == locale.languageCode;

  TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;
}

extension IsDarkMode on BuildContext {
  bool get isDarkMode =>
      Theme.of(this).brightness == Brightness.dark;
}

extension StringExtension on String {
  String get capital => this[0].toUpperCase() + substring(1);
}
