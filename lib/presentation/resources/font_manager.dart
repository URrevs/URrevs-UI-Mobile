import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontConstants {
  static const String tajawal = "Tajawal";
}

class FontSizeManager {
  static double get s13 => 13.sp;
  static double get s14 => 14.sp;
  static double get s15 => 15.sp;
  static double get s16 => 16.sp;
  static double get s18 => 18.sp;
  static double get s20 => 20.sp;
  static double get s22 => 22.sp;
}

class FontWeightManager {
  static const FontWeight w300 = FontWeight.w300;
  static const FontWeight w400 = FontWeight.w400;
  // font weight 500 needs to be changed to 600
  // there is no seen difference in the application between 400 & 500
  // it seems that weights 400, 600 and 700 are three distinct font weights
  // while font weight 500 is not different from 400
  static const FontWeight w500 = FontWeight.w600;
  static const FontWeight w700 = FontWeight.w700;
  static const FontWeight w800 = FontWeight.w800;
  static const FontWeight w900 = FontWeight.w900;
}
