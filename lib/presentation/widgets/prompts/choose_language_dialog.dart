import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class ChooseLanguageDialog extends StatefulWidget {
  const ChooseLanguageDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseLanguageDialog> createState() => _ChooseLanguageDialogState();
}

class _ChooseLanguageDialogState extends State<ChooseLanguageDialog> {
  late LanguageType? _languageType =
      context.isArabic ? LanguageType.ar : LanguageType.en;

  void _setLang(LanguageType? languageType) {
    if (languageType != null) {
      context.setLocale(languageType.locale);
    }
    setState(() => _languageType = languageType);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: LocaleKeys.language.tr(),
      hasTitle: true,
      content: Column(
        children: [
          RadioListTile<LanguageType>(
            value: LanguageType.ar,
            groupValue: _languageType,
            onChanged: _setLang,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            title: Text(
              LocaleKeys.arabic.tr(),
              style: TextStyleManager.s16w400.copyWith(
                color: ColorManager.black,
              ),
            ),
          ),
          RadioListTile<LanguageType>(
            value: LanguageType.en,
            groupValue: _languageType,
            onChanged: _setLang,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            title: Text(
              LocaleKeys.english.tr(),
              style: TextStyleManager.s16w400.copyWith(
                color: ColorManager.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
