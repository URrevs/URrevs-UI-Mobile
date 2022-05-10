import 'dart:io';

import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  static const String routeName = 'TermsAndConditionsScreen';

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
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
      appBar: AppBar(),
      body: SafeArea(
        child: WebView(
          initialUrl: context.isArabic? 'https://docs.google.com/document/d/e/2PACX-1vTG4kawFFmI0ku7erJPGiOlrp6gYW4Ybj-_qHFMSlTWqgI2dSTPYZPTraZh2MMzqxMn7KmZVL0QiOqJ/pub':
          'https://docs.google.com/document/d/e/2PACX-1vSeDAxcK6LJPF1S7Omc-PYfSWbOwLidsq7zQCOMyBu_eQDwnwKdPNvrVPbRAJxWlBV6VE7WQhaExhix/pub',
        javascriptMode: JavascriptMode.unrestricted,
        
        ),
      ),
    );
  }
}
