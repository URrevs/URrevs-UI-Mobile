import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const String routeName = 'SettingsScreen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarWithTitle(
        context: context,
        title: LocaleKeys.settings.tr(),
      ),
      body: SafeArea(
        child: ListView(children: [
          ItemTile(
            title: LocaleKeys.language.tr(),
            subtitle: context.isArabic
                ? LocaleKeys.arabic.tr()
                : LocaleKeys.english.tr(),
            iconData: Icons.language_outlined,
            onTap: () {},
          ),
          ItemTile(
            title: LocaleKeys.theme.tr(),
            subtitle: !context.isDarkMode
                ? LocaleKeys.lightTheme.tr()
                : LocaleKeys.darkTheme.tr(),
            iconData: !context.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.brightness_2_outlined,
            onTap: () {},
          ),
        ]),
      ),
    );
  }
}
