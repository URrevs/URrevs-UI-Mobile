import 'package:flutter/material.dart';

import 'package:urrevs_ui_mobile/presentation/resources/theme_manager.dart';

class ColorPair {
  Color light;
  Color dark;
  ColorPair({
    required this.light,
    required this.dark,
  });

  Color pickColor() => ThemeManager.isLight ? light : dark;
}

class ColorManager {
  static Color get blue => ColorPair(
        light: Color(0xff2196F3),
        dark: Color(0xff2196F3),
      ).pickColor();

  static Color get cyan => ColorPair(
        light: Color(0xff22CBF4),
        dark: Color(0xff22CBF4),
      ).pickColor();

  static Color get pink => ColorPair(
        light: Color(0xffFF6C89),
        dark: Colors.red,
      ).pickColor();

  static Color get orange => ColorPair(
        light: Color(0xffFF8E52),
        dark: Color(0xffFF8E52),
      ).pickColor();

  static Color get grey => ColorPair(
        light: Color(0xff65676B),
        dark: Color(0xff65676B),
      ).pickColor();

  static Color get buttonGrey => ColorPair(
        light: Color(0xff606266),
        dark: Color(0xff606266),
      ).pickColor();

  static Color get backgroundGrey => ColorPair(
        light: Color(0xffF0F2F5),
        dark: Color(0xffF0F2F5),
      ).pickColor();

  static Color get black => ColorPair(
        light: Color(0xff050505),
        dark: Color(0xff050505),
      ).pickColor();

  static Color get commentBlack => ColorPair(
        light: Color(0xff000000),
        dark: Color(0xff000000),
      ).pickColor();

  static Color get white => ColorPair(
        light: Colors.white,
        dark: Colors.white,
      ).pickColor();

  static Color get transparent => ColorPair(
        light: Colors.transparent,
        dark: Colors.transparent,
      ).pickColor();
}
