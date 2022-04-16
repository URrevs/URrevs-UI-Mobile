import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';

extension IsArabic on BuildContext {
  bool get isArabic => LanguageType.ar.name == locale.languageCode;
}
