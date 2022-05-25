import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class ChooseThemeModeDialog extends ConsumerStatefulWidget {
  const ChooseThemeModeDialog({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ChooseThemeModeDialog> createState() => _ChooseThemeModeState();
}

class _ChooseThemeModeState extends ConsumerState<ChooseThemeModeDialog> {
  late ThemeMode? _themeMode = ref.watch(themeModeProvider);

  void _setThemeMode(ThemeMode? themeMode) {
    if (themeMode != null) {
      ref.read(themeModeProvider.notifier).setThemeMode(themeMode);
    }
    setState(() => _themeMode = themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: LocaleKeys.theme.tr(),
      hasTitle: true,
      content: Column(
        children: [
          RadioListTile<ThemeMode>(
            value: ThemeMode.light,
            groupValue: _themeMode,
            onChanged: _setThemeMode,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            title: Text(
              LocaleKeys.lightTheme.tr(),
              style: TextStyleManager.s16w400.copyWith(
                color: ColorManager.black,
              ),
            ),
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.dark,
            groupValue: _themeMode,
            onChanged: _setThemeMode,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            title: Text(
              LocaleKeys.darkTheme.tr(),
              style: TextStyleManager.s16w400.copyWith(
                color: ColorManager.black,
              ),
            ),
          ),
          RadioListTile<ThemeMode>(
            value: ThemeMode.system,
            groupValue: _themeMode,
            onChanged: _setThemeMode,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            title: Text(
              LocaleKeys.systemTheme.tr(),
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
