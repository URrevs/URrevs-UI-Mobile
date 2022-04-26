import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AppBars {
  static AppBar appBarWithURrevsLogo(bool showTabBar) => AppBar(
        bottom: showTabBar
            ? TabBar(
                tabs: [
                  Tab(text: LocaleKeys.tabBarReview.tr()),
                  Tab(text: LocaleKeys.tabBarQuestion.tr()),
                ],
              )
            : null,
      );
}
