import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/card_body_review_block_star_bar.dart';

/// Rating table which contains 7 rows of star ratings of different aspects
/// of the product.
/// The 7 rows are collapsed into 1 row at the collapsed state of the review
/// card.
class CardBodyRatingBlock extends StatelessWidget {
  const CardBodyRatingBlock({
    Key? key,
    required this.expanded,
    required this.scores,
    required this.ratingCriteria,
    required this.fullscreen,
  })  : assert(scores.length == ratingCriteria.length),
        super(key: key);

  /// Whether the card is expanded or not.
  final bool expanded;

  /// List of rating criteria to be show in the [CardBodyRatingBlock].
  final List<String> ratingCriteria;

  /// List of scores corresponding to the [ratingCriteria] list to be also shown
  /// in the [CardBodyRatingBlock].
  final List<int> scores;

  final bool fullscreen;

  @override
  Widget build(BuildContext context) {
    /// Number of star rows shown in review card.
    /// If review card is expanded, all 7 star rows are shown.
    /// If review card is not expanded, only 1 star row is shown.
    int shownStarRows = (expanded || fullscreen) ? scores.length : 1;
    return Column(
      children: [
        for (int i = 0; i < shownStarRows; i++) ...[
          CardBodyReviewBlockStarBar(
            ratingCriteria: ratingCriteria[i].tr(),
            score: scores[i],
          ),
          4.verticalSpace,
        ]
      ],
    );
  }
}
