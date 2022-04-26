import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalSpacesBetween {
  static Widget get replies => 9.verticalSpace;
  static Widget get interactionBodyAndShowRepliesButton => 6.verticalSpace;
  static Widget get interactionBodyAndReplies => 6.verticalSpace;
  static Widget get interactionTrees => 9.verticalSpace;
  static Widget get interactionsListAndMoreCommentsButton => 9.verticalSpace;
}

class AppWidth {
  static double get w1 => 1.w;
  static double get w2 => 2.w;
}

class AppSize {
  static double get s0 => 0.sp * 1.1;
  static double get s4 => 4.sp * 1.1;
  static double get s6 => 6.sp * 1.1;
  static double get s8 => 8.sp * 1.1;
  static double get s14 => 14.sp * 1.1;
  static double get s16 => 16.sp * 1.1;
  static double get s18 => 18.sp * 1.1;
  static double get s20 => 20.sp * 1.1;
  static double get s22 => 22.sp * 1.1;
}

class AppRadius {
  static double get r10 => 10.r;
  static double get appBarAvatarRadius => 12.5.r;
  static double get questionMarkNotchRadius => 14.r;
  static double get cardHeaderAvatarRadius => 20;
  static double get commentTreeAvatarRadius => 16.r;
  static double get replyAvatarRadius => 12.r;
  static double get interactionBodyRadius => 12.r;
  static double get postCardRadius => 15.r;
  static double get updatedListTile => 12.r;
}

class AppNumericValues {
  /// Number of letters show in a review card in the section of pros & cons when
  /// the card is collapsed.
  static int get collapsedMaxLetters => 600;

  /// Number of letters show in a review card in the section of pros & cons when
  /// the card is expanded.
  static int get expandedMaxLetters => 1200;

  static int get interactionsMaxLetters => 50;
}

class AppDuration {
  static const Duration d300 = Duration(milliseconds: 300);
}
