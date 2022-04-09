import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/resources/routes_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/theme_manager.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  TextStyle get headline1 => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: ColorManager.black,
        overflow: TextOverflow.ellipsis,
      );

  ThemeData get lightThemeData => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: FontConstants.tajawal,
        colorScheme: ColorScheme.light().copyWith(
          primary: ColorManager.blue,
        ),
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
            textStyle: headline1,
            // minimumSize: Size(80.w, 30.h),
            // maximumSize: Size(100.w, 40.h),
          ),
        ),
        textTheme: TextTheme(
          headline1: headline1,
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

  @override
  Widget build(BuildContext context, ref) {
    return ScreenUtilInit(
      designSize: Size(411, 731),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: () => MaterialApp(
        title: LocaleKeys.urrevs.tr(),
        initialRoute: Routes.home,
        onGenerateRoute: RouteGenerator.getRoute,
        themeMode: ref.watch(themeModeProvider),
        theme: lightThemeData,
        darkTheme: ThemeManager.dark,
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
