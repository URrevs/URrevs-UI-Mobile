import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

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
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarWithTitle(
        context: context,
        title: LocaleKeys.privacyPolicy.tr(),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: context.isArabic? 'https://docs.google.com/document/d/e/2PACX-1vQmvvk-TcAXnuEVzJsF6XjVKCP1XrUOD100p5LzRTvBxyO1Wqn4NdfBWyr0btht0mx0EhOcnp-rjEjE/pub':
          'https://docs.google.com/document/d/e/2PACX-1vTtMyGcmy2IUsM_lXHrIjhoybCWcdYM252L9VDhyklLysGYbBzd5tGDfqr8Zh3giwO0408pXBV-VJJL/pub',
        javascriptMode: JavascriptMode.unrestricted,
        
        ),
      ),
    );
  }
}


