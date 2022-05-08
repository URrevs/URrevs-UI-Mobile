import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  static const String routeName = 'AboutUsScreen';

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarWithTitle(
        context: context,
        title: LocaleKeys.termsOfUse.tr(),
      ),
      body: SafeArea(child: Container()),
    );
  }
}
