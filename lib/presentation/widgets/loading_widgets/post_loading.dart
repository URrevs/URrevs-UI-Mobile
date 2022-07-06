import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/helpers/button_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/helpers/circle_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/helpers/text_loading.dart';

class PostLoading extends StatelessWidget {
  const PostLoading({
    Key? key,
    this.isQuestion = false,
  }) : super(key: key);

  final bool isQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderLoading(),
            40.verticalSpace,
            _buildBodyLoading(),
            40.verticalSpace,
            _buildButtonsBarLoading()
          ],
        ),
      ),
    );
  }

  Row _buildButtonsBarLoading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonLoading(),
        ButtonLoading(),
        ButtonLoading(),
      ],
    );
  }

  Column _buildBodyLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLoading(width: 100.w),
            5.verticalSpace,
            TextLoading(width: 0.8.sw),
            5.verticalSpace,
            TextLoading(width: 0.8.sw),
            5.verticalSpace,
            TextLoading(width: 0.5.sw),
          ],
        ),
        if (!isQuestion) ...[
          15.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextLoading(width: 100.w),
              5.verticalSpace,
              TextLoading(width: 0.8.sw),
              5.verticalSpace,
              TextLoading(width: 0.8.sw),
              5.verticalSpace,
              TextLoading(width: 0.5.sw),
            ],
          ),
        ]
      ],
    );
  }

  Row _buildHeaderLoading() {
    return Row(
      children: [
        CircleLoading(radius: 20),
        5.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                TextLoading(width: 100.w),
                10.horizontalSpace,
                TextLoading(width: 100.w),
              ],
            ),
            10.verticalSpace,
            Row(
              children: [
                TextLoading(width: 120.w),
                10.horizontalSpace,
                TextLoading(width: 150.w),
              ],
            ),
          ],
        )
      ],
    );
  }
}
