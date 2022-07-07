import 'package:flutter/foundation.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';

void launchUrlWithCustomTabs(String stringUrl) async {
  try {
    await launch(
      stringUrl,
      customTabsOption: CustomTabsOption(
        toolbarColor: ColorManager.white,
        enableDefaultShare: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        animation: CustomTabsSystemAnimation.fade(),
        extraCustomTabs: const <String>[
          'org.mozilla.firefox',
          'com.microsoft.emmx',
        ],
      ),
    );
  } catch (e) {
    // An exception is thrown if browser app is not installed on Android device.
    debugPrint(e.toString());
  }
}
