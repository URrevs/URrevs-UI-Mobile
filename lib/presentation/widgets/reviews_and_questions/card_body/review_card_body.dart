import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/card_body_expand_circle.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/card_body_rating_block.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/card_body_review_text.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/see_more_button.dart';

/// Middle block of the review card.
/// Contains star ratings and pros and cons of the product.
class ReviewCardBody extends StatefulWidget {
  const ReviewCardBody({
    Key? key,
    required this.scores,
    required this.prosText,
    required this.consText,
    required this.ratingCriteria,
    required this.showExpandCircle,
    required this.hideSeeMoreIfNoNeedForExpansion,
  }) : super(key: key);

  /// List of rating criteria to be show in the [CardBodyRatingBlock].
  final List<String> ratingCriteria;

  /// List of scores corresponding to the [ratingCriteria] list to be also shown
  /// in the [CardBodyRatingBlock].
  final List<int> scores;

  /// The text which the user written in the pros section when submitting the
  /// review.
  final String prosText;

  /// The text which the user written in the cons section when submitting the
  /// review.
  final String consText;

  /// Whether to show expand circle or not.
  final bool showExpandCircle;

  /// If set to true, [SeeMoreButton] would be hidden at the state of
  /// the card where both pros and cons text are both shown completely. This
  /// case only occurs when the the sum of pros text length and cons text length
  /// is less than or equal to collapsedMaxLetters.
  ///
  /// This is set to true at the case of company review card.
  final bool hideSeeMoreIfNoNeedForExpansion;

  @override
  State<ReviewCardBody> createState() => _ReviewCardBodyState();
}

class _ReviewCardBodyState extends State<ReviewCardBody> {
  /// Whether the card is expanded or not.
  bool _expanded = false;

  /// The max letters limit applied at any moment to the review card.
  /// It is based on the [_expanded] condition of the review card.
  int get maxLetters => _expanded
      ? AppNumericValues.expandedMaxLetters
      : AppNumericValues.collapsedMaxLetters;

  /// Returns a boolean value representing whether the whole pros and cons texts
  /// are shown or substrings of them.
  bool get prosAndConsCut =>
      widget.prosText.length + widget.consText.length > maxLetters;

  /// Returns true when the card is at a state in which we don't need to make
  /// an expansion. This state is when the sum of pros text length and cons text
  /// length is less than or equal collapsedMaxLetters.
  bool get noNeedForExpansion =>
      widget.prosText.length + widget.consText.length <=
      AppNumericValues.collapsedMaxLetters;

  void setExpandedState(bool value) {
    setState(() {
      _expanded = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        _expanded = !_expanded;
      }),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardBodyRatingBlock(
              expanded: _expanded,
              scores: widget.scores,
              ratingCriteria: widget.ratingCriteria,
            ),
            if (widget.showExpandCircle) ...[
              10.verticalSpace,
              CardBodyExpandCircle(expanded: _expanded),
            ],
            10.verticalSpace,
            CardBodyReviewText(
              prosText: widget.prosText,
              consText: widget.consText,
              maxLetters: maxLetters,
              expanded: _expanded,
              prosAndConsCut: prosAndConsCut,
              setExpandedState: setExpandedState,
              noNeedForExpansion: noNeedForExpansion,
              hideSeeMoreIfNoNeedForExpansion: false,
            ),
          ],
        ),
      ),
    );
  }
}
