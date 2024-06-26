import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/send_and_forget_requests.dart';
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
    required this.cardType,
    required this.fullscreen,
    required this.postId,
    required this.targetType,
      required this.userId,
      required this.postType
  }) : super(key: key);

  final String userId;
  final PostType postType;

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

  final CardType cardType;

  /// If set to true, [SeeMoreButton] would be hidden at the state of
  /// the card where both pros and cons text are both shown completely. This
  /// case only occurs when the the sum of pros text length and cons text length
  /// is less than or equal to collapsedMaxLetters.
  ///
  /// This is set to true at the case of company review card.
  final bool hideSeeMoreIfNoNeedForExpansion;

  final bool fullscreen;

  final String postId;
  final TargetType targetType;

  @override
  State<ReviewCardBody> createState() => _ReviewCardBodyState();
}

class _ReviewCardBodyState extends State<ReviewCardBody> {
  /// Whether the card is expanded or not.
  bool _expanded = false;

  bool _viewsIncremented = false;

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
      widget.cardType != CardType.productReview &&
      widget.prosText.length + widget.consText.length <=
          AppNumericValues.collapsedMaxLetters;

  void setExpandedState(bool value) {
    if (!_viewsIncremented) {
      SendAndForgetRequests.increaseViewCount(
          postId: widget.postId, targetType: widget.targetType);
      SendAndForgetRequests.userPressesSeeMore(
          postId: widget.postId, targetType: widget.targetType);
    }
    setState(() {
      _expanded = value;
      _viewsIncremented = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: noNeedForExpansion ? null : () => setExpandedState(!_expanded),
      child: Padding(
        padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardBodyRatingBlock(
              expanded: _expanded,
              scores: widget.scores,
              ratingCriteria: widget.ratingCriteria,
              fullscreen: widget.fullscreen,
            ),
            if (widget.showExpandCircle && !widget.fullscreen) ...[
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
              noNeedForExpansion: noNeedForExpansion,
              hideSeeMoreIfNoNeedForExpansion: false,
              fullscreen: widget.fullscreen,
            ),
            if (!widget.fullscreen)
              SeeMoreButton(
                expanded: _expanded,
                parentTextCut: prosAndConsCut,
                setExpandedState: setExpandedState,
                noNeedForExpansion: noNeedForExpansion,
                hideSeeMoreIfNoNeedForExpansion:
                    widget.hideSeeMoreIfNoNeedForExpansion,
                usedInInteraction: false,
                cardType: widget.cardType,
                postId: widget.postId,
                postUserId: widget.userId,
                postType: widget.postType,
              )
          ],
        ),
      ),
    );
  }
}
