import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
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
      body: SafeArea(child: Container()),
    );
  }
}
