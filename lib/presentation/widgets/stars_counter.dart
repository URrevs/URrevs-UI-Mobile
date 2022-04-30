
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';

class StarsCounter extends StatelessWidget {
  const StarsCounter({
    required this.percentage,
    Key? key,
  }) : super(key: key);

  /// Percentage value between 0.0 and 1.0
  final double percentage;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          LinearPercentIndicator(
            leading: Icon(
              IconsManager.star,
              color: ColorManager.blue,
              size: 30.sp,
            ),
            animation: true,
            isRTL: context.isArabic,
            barRadius: Radius.circular(30.r),
            width: 330.w,
            lineHeight: 14.0,
            percent: percentage,
            backgroundColor: ColorManager.white,
            progressColor: ColorManager.blue,
          ),
        ],
      ),
    );
  }
}
