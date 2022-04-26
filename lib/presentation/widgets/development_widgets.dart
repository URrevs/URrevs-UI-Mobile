import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';

class ToggleLocaleButton extends StatelessWidget {
  const ToggleLocaleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (context.isArabic) {
          context.setLocale(LanguageType.en.locale);
        } else {
          context.setLocale(LanguageType.ar.locale);
        }
      },
      child: Text('TOGGLE LOCALE'),
    );
  }
}
