import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppHeight {
  static double get h8 => 8.h;
}

class AppWidth {
  static double get w1 => 1.w;
  static double get w2 => 2.w;
}

class AppSize {
  static double get s0 => 0.sp;
  static double get s4 => 4.sp;
  static double get s6 => 6.sp;
  static double get s8 => 8.sp;
  static double get s14 => 14.sp;
  static double get s16 => 16.sp;
  static double get s18 => 18.sp;
  static double get s20 => 20.sp;
}

class AppRadius {
  static double get r10 => 10.r;
}

class AppNumericValues {
  /// Number of letters show in a review card in the section of pros & cons when
  /// the card is collapsed.
  static int get collapsedMaxLetters => 600;

  /// Number of letters show in a review card in the section of pros & cons when
  /// the card is expanded.
  static int get expandedMaxLetters => 700;
}

class DurationManager {
  static const Duration d300 = Duration(milliseconds: 300);
}
