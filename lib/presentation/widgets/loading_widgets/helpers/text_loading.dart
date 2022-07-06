import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';

class TextLoading extends StatelessWidget {
  const TextLoading({
    Key? key,
    required this.width,
    this.height = 15,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerColor: ColorManager.white,
      shimmerDuration: AppDuration.skeletonLoading.inMilliseconds,
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
    );
  }
}
