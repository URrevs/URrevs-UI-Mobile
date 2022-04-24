import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

/// A signle star bar consisting of a rating criteria and the corresponding
/// score that the product or the company have.
class CardBodyReviewBlockStarBar extends StatelessWidget {
  const CardBodyReviewBlockStarBar({
    Key? key,
    required this.ratingCriteria,
    required this.score,
  }) : super(key: key);

  /// Rating criteria name to be shown in the star bar.
  final String ratingCriteria;

  /// The corresponding name of received [ratingCriteria].
  final int score;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          ratingCriteria + ":",
          style: context.isArabic
              ? TextStyleManager.s14w500
              : TextStyleManager.s16w500,
        ),
        RatingBar.builder(
          itemSize: 18.sp,
          ignoreGestures: true,
          initialRating: score.toDouble(),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 3.sp),
          itemBuilder: (context, _) => SvgPicture.asset(
            SvgAssets.star,
            color: ColorManager.blue,
          ),
          unratedColor: ColorManager.grey,
          onRatingUpdate: (rating) {
            print(rating);
          },
        )
      ],
    );
  }
}
