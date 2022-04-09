import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  ThemeMode getThemeMode() {
    const kDark = 'dark'; //ThemeMode.dark.name
    const kLight = 'light'; //ThemeMode.light.name

    String? themeMode =
        _sharedPreferences.getString(SharedPreferencesKeys.themeMode);
    if (themeMode == null) {
      return ThemeMode.system;
    }
    switch (themeMode) {
      case kDark:
        return ThemeMode.dark;
      case kLight:
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  void setThemeMode(ThemeMode themeMode) {
    _sharedPreferences.setString(
        SharedPreferencesKeys.themeMode, themeMode.name);
  }
}

class SharedPreferencesKeys {
  static const String themeMode = "themeMode";
}
