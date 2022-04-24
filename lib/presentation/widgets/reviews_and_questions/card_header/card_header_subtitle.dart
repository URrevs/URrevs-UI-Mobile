import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Icon(Icons.circle, size: 4.sp, color: ColorManager.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    // english font is already bigger than arabic font
    // so english font size should be 12 px
    // while arabic font size should be the regular 14 px
    double size =
        context.locale.languageCode == LanguageType.en.name ? 14.sp : 14.sp;
    TextStyle style =
        Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: size);

    final String postedDateStr =
        DateFormat.yMMMMd(context.locale.languageCode).format(postedDate);
    String? usedSinceDateStr;
    if (usedSinceDate != null) {
      usedSinceDateStr =
          timeago.format(usedSinceDate!, locale: context.locale.languageCode);
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
            Icon(Icons.remove_red_eye),
            3.horizontalSpace,
            Flexible(
              flex: 20,
              child: Text(numberFormat.format(views), style: style),
            )
          ]
        ],
      ),
    );
  }
}
