import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class InteractionLikeCounter extends StatelessWidget {
  const InteractionLikeCounter({
    Key? key,
    required this.likeCount,
    required this.isLike,
    required this.inQuestionCard,
  }) : super(key: key);

  final int likeCount;
  final bool isLike;
  final bool inQuestionCard;

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat =
        NumberFormat.compact(locale: context.locale.languageCode);
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color:
              inQuestionCard ? ColorManager.backgroundGrey : ColorManager.white,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.ltr,
          children: [
            Text(
              numberFormat.format(likeCount),
              style: TextStyleManager.s14w400,
            ),
            2.horizontalSpace,
            Container(
              margin: EdgeInsets.only(bottom: isLike ? 5.h : 8.h),
              child: Icon(
                isLike ? IconsManager.likeFilled : IconsManager.upvote,
                color: ColorManager.blue,
                size: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
