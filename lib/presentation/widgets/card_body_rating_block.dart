import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_body_review_block_star_bar.dart';

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
  })  : assert(scores.length == ratingCriteria.length),
        super(key: key);

  final bool expanded;
  final List<int> scores;
  final List<String> ratingCriteria;

  @override
  Widget build(BuildContext context) {
    /// Number of star rows shown in review card.
    /// If review card is expanded, all 7 star rows are shown.
    /// If review card is not expanded, only 1 star row is shown.
    int shownStarRows = expanded ? scores.length : 1;
    return Column(
      children: [
        for (int i = 0; i < shownStarRows; i++) ...[
          CardBodyReviewBlockStarBar(
            ratingCriteria: ratingCriteria[i].tr(),
            score: scores[i],
          ),
        ]
      ],
    );
  }
}
