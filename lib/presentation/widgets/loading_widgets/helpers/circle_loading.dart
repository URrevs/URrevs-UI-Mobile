import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({
    Key? key,
    required this.radius,
  }) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerColor: ColorManager.white,
      shimmerDuration: AppDuration.skeletonLoading.inMilliseconds,
      borderRadius: BorderRadius.circular(radius),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey.withOpacity(0.3),
      ),
    );
  }
}
