import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerColor: ColorManager.white,
      shimmerDuration: AppDuration.skeletonLoading.inMilliseconds,
      borderRadius: BorderRadius.circular(7.r),
      child: Container(
        width: 100.w,
        height: 35.w,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(7.r),
        ),
      ),
    );
  }
}
