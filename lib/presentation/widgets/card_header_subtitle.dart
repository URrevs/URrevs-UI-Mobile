import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Builds the line containing dates & views of the review.
class CardHeaderSubtitle extends StatelessWidget {
  const CardHeaderSubtitle({
    Key? key,
    required this.postedDate,
    required this.usedSinceDate,
    required this.views,
    required this.showUsedSincePart,
  }) : super(key: key);

  final DateTime postedDate;
  final DateTime usedSinceDate;
  final int views;
  final bool showUsedSincePart;

  @override
  Widget build(BuildContext context) {
    // english font is already bigger than arabic font
    // so english font size should be 12 px
    // while arabic font size should be the regular 14 px
    double size =
        context.locale.languageCode == LanguageType.en.name ? 12.sp : 14.sp;
    TextStyle style =
        Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: size);

    final String postedDateStr =
        DateFormat.yMMMMd(context.locale.languageCode).format(postedDate);
    final String usedSinceDateStr =
        DateFormat.yMMMM(context.locale.languageCode).format(usedSinceDate);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(postedDateStr, style: style),
        Padding(
          padding: EdgeInsets.all(1.sp),
          child: Icon(Icons.circle, size: 6.sp),
        ),
        if (showUsedSincePart) ...[
          Text(
            LocaleKeys.usedSince.tr() + " " + usedSinceDateStr,
            style: style,
          ),
          Padding(
            padding: EdgeInsets.all(1.sp),
            child: Icon(Icons.circle, size: 6.sp),
          ),
        ],
        Icon(Icons.remove_red_eye),
        1.horizontalSpace,
        Text(views.toString(), style: style)
      ],
    );
  }
}
