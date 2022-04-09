import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/review_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => context.setLocale(LanguageType.ar.locale),
            child: Text('ar'),
          ),
          ElevatedButton(
            onPressed: () => context.setLocale(LanguageType.en.locale),
            child: Text('en'),
          ),
          ElevatedButton(
            onPressed: () {
              print("scale width: ${ScreenUtil().scaleWidth}");
              print("scale height: ${ScreenUtil().scaleHeight}");
              print("screen width: ${ScreenUtil().screenWidth}");
              print("ui size: ${ScreenUtil().uiSize}");
            },
            child: Text('screen util'),
          ),
        ],
      ),
      body: Theme(
        data: lightThemeData,
        child: ListView(
          padding: EdgeInsets.all(10.sp),
          children: [ReviewCard()],
        ),
      ),
    );
  }
}
