import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_body_expand_circle.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_body_rating_block.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_body_review_text.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_body_see_more_button.dart';

/// Middle block of the review card.
/// Contains star ratings and pros and cons of the product.
class CardBody extends StatefulWidget {
  /// Must take an array of scores of 7 items.
  const CardBody({
    Key? key,
    required this.scores,
    required this.prosText,
    required this.consText,
    required this.ratingCriteria,
    required this.showExpandCircle,
    required this.hideSeeMoreIfNoNeedForExpansion,
  }) : super(key: key);

  // defined before in ProductReviewCard
  final List<int> scores;
  final List<String> ratingCriteria;
  final String prosText;
  final String consText;
  final bool showExpandCircle;
  final bool hideSeeMoreIfNoNeedForExpansion;

  @override
  State<CardBody> createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> {
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
            ),
            CardBodySeeMoreButton(
              expanded: _expanded,
              prosAndConsCut: prosAndConsCut,
              setExpandedState: setExpandedState,
              noNeedForExpansion: noNeedForExpansion,
              hideSeeMoreIfNoNeedForExpansion:
                  widget.hideSeeMoreIfNoNeedForExpansion,
            ),
          ],
        ),
      ),
    );
  }
}
