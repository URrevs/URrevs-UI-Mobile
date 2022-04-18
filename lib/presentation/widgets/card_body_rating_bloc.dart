import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Rating table which contains 7 rows of star ratings of different aspects
/// of the product.
/// The 7 rows are collapsed into 1 row at the collapsed state of the review
/// card.
class CardBodyRatingBlock extends StatelessWidget {
  const CardBodyRatingBlock({
    Key? key,
    required this.expanded,
    required this.scores,
  }) : super(key: key);

  final bool expanded;
  final List<int> scores;

  /// The seven rating criteria show in a product review card.
  final List<String> _ratingCriteria = const [
    LocaleKeys.generalProductRating,
    LocaleKeys.userInterface,
    LocaleKeys.manufacturingQuality,
    LocaleKeys.priceQuality,
    LocaleKeys.camera,
    LocaleKeys.callsQuality,
    LocaleKeys.battery,
  ];

  @override
  Widget build(BuildContext context) {
    /// Number of star rows shown in review card.
    /// If review card is expanded, all 7 star rows are shown.
    /// If review card is not expanded, only 1 star row is shown.
    int shownStarRows = expanded ? scores.length : 1;
    return Column(
      children: [
        for (int i = 0; i < shownStarRows; i++) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _ratingCriteria[i].tr() + ":",
                style: Theme.of(context).textTheme.headline2,
              ),
              RatingBar.builder(
                itemSize: 24.sp,
                ignoreGestures: true,
                initialRating: scores[i].toDouble(),
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
          ),
        ]
      ],
    );
  }
}
