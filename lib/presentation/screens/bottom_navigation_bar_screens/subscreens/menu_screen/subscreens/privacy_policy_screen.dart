import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../translations/locale_keys.g.dart';
import '../../../../../widgets/app_bars.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  static const String routeName = 'PrivacyPolicyScreen';

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarWithTitle(
        context: context,
        title: LocaleKeys.privacyPolicy.tr(),
      ),
      body: SafeArea(child: Container()),
    );
  }
}
