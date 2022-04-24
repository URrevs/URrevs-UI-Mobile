import 'package:flutter/cupertino.dart';

enum LanguageType { en, ar }

extension LanguageTypeLocale on LanguageType {
  Locale get locale {
    return Locale(name);
  }

  TextDirection get textDirection {
    switch (this) {
      case LanguageType.en:
        return TextDirection.ltr;
      case LanguageType.ar:
        return TextDirection.rtl;
    }
  }
}
