import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          style: TextStyleManager.s14w500,
        ),
        RatingBar.builder(
          itemSize: 24.sp,
          ignoreGestures: true,
          initialRating: score.toDouble(),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.sp),
          itemBuilder: (context, _) => Icon(
            Icons.star_rate_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        )
      ],
    );
  }
}
