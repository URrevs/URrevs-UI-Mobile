import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';

class ThemeManager {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: FontConstants.tajawal,
    iconTheme: IconThemeData(color: ColorManager.black),
    colorScheme: ColorScheme.light().copyWith(
      primary: ColorManager.blue,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: ColorManager.grey,
    ),
    textTheme: TextTheme(
      headline1: ThemeData.light()
          .textTheme
          .headline1!
          .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      subtitle1: TextStyle(fontSize: 14.sp),
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
