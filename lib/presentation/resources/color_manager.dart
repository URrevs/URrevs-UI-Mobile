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
        dark: Color(0xffFF6C89)
      ).pickColor();

  static Color get orange => ColorPair(
        light: Color(0xffFF8E52),
        dark: Color(0xffFF8E52),
      ).pickColor();

  static Color get golden => ColorPair(
        light: Color(0xffFFBF00),
        dark: Color(0xffFFBF00),
      ).pickColor();

  static Color get grey => ColorPair(
        light: Color(0xff65676B),
        dark: Color(0xff9a9894),
      ).pickColor();

  static Color get red => ColorPair(
        light: Color(0xffE41D1D),
        dark: Color(0xffE41D1D),
      ).pickColor();

  static Color get dividerGrey => ColorPair(
        light: Color(0xffCED0D4),
        dark: Color(0xff312f2b),
      ).pickColor();

  static Color get buttonGrey => ColorPair(
        light: Color(0xff606266),
        dark: Color(0xff9f9d99),
      ).pickColor();

  static Color get strokeGrey => ColorPair(
        light: Color(0xff606266),
        dark: Color(0xff9f9d99),
      ).pickColor();

  static Color get backgroundGrey => ColorPair(
        light: Color(0xFFF0F2F5),
        dark: Color(0xff18191A), // facebook background black
      ).pickColor();

  static Color get textFieldGrey => ColorPair(
        light: Color(0xffF9F9F9),
        dark: Color(0xff060606),
      ).pickColor();

  static Color get dialogCloseIconBackgroundGrey => ColorPair(
        light: Color(0xffe8e8e8),
        dark: Color(0xff171717),
      ).pickColor();

  static Color get appBarIconBackground => ColorPair(
        light: Color(0xffE5E5E7),
        dark: Color(0xff1a1a18),
      ).pickColor();

  static Color get snackBarGrey => ColorPair(
        light: Color(0xffc4c4c4),
        dark: Color(0xff3b3b3b),
      ).pickColor();

  static Color get black => ColorPair(
        light: Color.fromARGB(255, 5, 5, 5),
        dark: Color.fromARGB(255, 250, 250, 250),
      ).pickColor();

  static Color get commentBlack => ColorPair(
        light: Color(0xff000000),
        dark: Color(0xffffffff),
      ).pickColor();

  static Color get white => ColorPair(
        light: Colors.white,
        dark: Colors.black,
      ).pickColor();

  static Color get transparent => ColorPair(
        light: Colors.transparent,
        dark: Colors.transparent,
      ).pickColor();
}
