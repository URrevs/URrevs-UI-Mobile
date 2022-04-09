import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';

class ThemeManager {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: FontConstants.tajawal,
    colorScheme: ColorScheme.light().copyWith(
      primary: ColorManager.blue,
    ),
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: Colors.black12,
    fontFamily: FontConstants.tajawal,
    colorScheme: ColorScheme.dark().copyWith(
      primary: Colors.blue[300],
    ),
  );
}
