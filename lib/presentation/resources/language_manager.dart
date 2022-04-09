import 'package:flutter/cupertino.dart';

enum LanguageType { en, ar }

extension LanguageTypeLocale on LanguageType {
  Locale get locale {
    return Locale(name);
  }
}
