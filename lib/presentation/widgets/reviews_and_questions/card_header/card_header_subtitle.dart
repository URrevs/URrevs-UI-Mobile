import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Builds the line containing dates & views of the review.
class CardHeaderSubtitle extends StatelessWidget {
  const CardHeaderSubtitle({
    Key? key,
    required this.postedDate,
    required this.usedSinceDate,
    required this.views,
  }) : super(key: key);

  /// The date where the review was posted.
  final DateTime postedDate;

  /// The date from which the user started using the product.
  final DateTime? usedSinceDate;

  /// How many times this review was viewed.
  final int? views;

  Padding _buildDot() {
    return Padding(
      padding: EdgeInsets.only(right: 4.w, left: 4.w, bottom: 4.h),
      child: Icon(IconsManager.dot, size: 4.sp, color: ColorManager.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    // english font is already bigger than arabic font
    // so english font size should be 12 px
    // while arabic font size should be the regular 14 px
    // update
    // ------
    // actually, there is no overflow anymore, arabic and english fonts seem
    // to have the same sizes now
    double size = context.isArabic ? 14.sp : 14.sp;
    TextStyle style = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: ColorManager.grey,
    );

    final String postedDateStr = DateFormat.yMMMMd(context.locale.languageCode)
        .format(postedDate.toLocal());
    String? usedSinceDateStr;
    if (usedSinceDate != null) {
      DateTime truncatedUsedSinceDate = DateTime(
        usedSinceDate!.year,
        usedSinceDate!.month,
      );
      usedSinceDateStr = timeago.format(
        truncatedUsedSinceDate,
        locale: context.locale.languageCode,
        clock: postedDate,
      );
    }

    NumberFormat numberFormat =
        NumberFormat.compact(locale: context.locale.languageCode);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 33,
            child: Text(postedDateStr, style: style),
          ),
          if (usedSinceDateStr != null) ...[
            _buildDot(),
            Flexible(
              flex: 47,
              child: Text(
                LocaleKeys.usedThisFor.tr() + " " + usedSinceDateStr,
                style: style,
              ),
            ),
          ],
          if (views != null) ...[
            _buildDot(),
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: Icon(IconsManager.views),
            ),
            3.horizontalSpace,
            Flexible(
              flex: 20,
              child: Text(numberFormat.format(views), style: style),
            )
          ],_buildDot(),
           3.horizontalSpace,
          true? Tooltip(
            message: "هذه المراجعة موثقة بنسبة 33%",
            child: Padding(
              padding:  EdgeInsets.only(bottom: 5.h),
              child: Icon(Icons.check_circle,
              color: ColorManager.blue,
              size: 16.sp,
                  ),
            ),
          ): SizedBox(),
        ],
      ),
    );
  }
}
