import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';

class ThemeManager {
  static bool get isLight =>
      ProviderContainer().read(themeModeProvider) == ThemeMode.light;

  static TextStyle get headline1 => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: ColorManager.black,
        overflow: TextOverflow.ellipsis,
      );

  static ThemeData get light => ThemeData(
        scaffoldBackgroundColor: ColorManager.backgroundGrey,
        fontFamily: FontConstants.tajawal,
        dialogTheme: DialogTheme(
          backgroundColor: ColorManager.white,
          contentTextStyle: TextStyleManager.s16w500.copyWith(
            color: ColorManager.black,
            fontFamily: FontConstants.tajawal,
          ),
        ),
        colorScheme: ColorScheme.light().copyWith(
          primary: ColorManager.blue,
          secondary: ColorManager.blue,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorManager.blue,
          foregroundColor: ColorManager.white,
          extendedTextStyle: TextStyleManager.s14w700.copyWith(
            fontFamily: FontConstants.tajawal,
          ),
          extendedIconLabelSpacing: 9.w,
        ),
        visualDensity: VisualDensity.standard,
        iconTheme: IconThemeData(
          color: ColorManager.grey,
          size: 18.sp,
        ),
        listTileTheme: ListTileThemeData(
          iconColor: ColorManager.grey,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: ColorManager.grey,
            textStyle: ThemeManager.headline1.copyWith(
              fontFamily: FontConstants.tajawal,
            ),
            // minimumSize: Size(80.w, 30.h),
            // maximumSize: Size(100.w, 40.h),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          actionTextColor: ColorManager.blue,
          backgroundColor: ColorManager.snackBarGrey,
          contentTextStyle: TextStyleManager.s16w500.copyWith(
            color: ColorManager.black,
            fontFamily: FontConstants.tajawal,
          ),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.snackBar),
          ),
        ),
        textTheme: TextTheme(
          headline1: ThemeManager.headline1,
          headline2: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: ColorManager.black,
          ),
          bodyText1: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: ColorManager.black,
          ),
          subtitle1: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: ColorManager.grey,
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        scaffoldBackgroundColor: Colors.black12,
        fontFamily: FontConstants.tajawal,
        colorScheme: ColorScheme.dark().copyWith(
          primary: Colors.blue[300],
        ),
      );
}
