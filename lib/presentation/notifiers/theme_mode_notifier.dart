import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/app/app_preferences.dart';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(GetIt.I<AppPreferences>().getThemeMode());

  void setThemeMode(ThemeMode themeMode) {
    state = themeMode;
    GetIt.I<AppPreferences>().setThemeMode(themeMode);
  }
}
