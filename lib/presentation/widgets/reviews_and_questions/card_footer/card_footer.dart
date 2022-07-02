import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer_button_bar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer_interaction_bar.dart';

/// The bottom part of the review card.
/// Contains counters for likes, comments and shares.
/// Also contains buttons for like, comment and share.
class CardFooter extends StatelessWidget {
  const CardFooter({
    Key? key,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.liked,
    required this.useInReviewCard,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.cardType,
    required this.fullscreen,
    required this.postType,
    required this.postId,
    required this.userId,
    required this.postForReportCard,
  }) : super(key: key);

  /// Is the review liked by the current logged in user or not.
  final bool liked;

  /// Number of likes given to the review.
  final int likeCount;

  /// Number of comments on the review.
  final int commentCount;

  /// Number of shares to the review
  final int shareCount;

  /// Whether the [CardFooter] would be used in a review card or
  /// not.
  final bool useInReviewCard;

  /// Callback invoked when like (or upvote) buttons are pressed.
  final VoidCallback onLike;

  /// Callback invoked when comment (or answer) buttons are pressed.
  final VoidCallback onComment;

  /// Callback invoked when share button is pressed.
  final VoidCallback onShare;

  final bool fullscreen;

  final CardType cardType;

  final PostType postType;

  final String postId;
  final String userId;
  final bool postForReportCard;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CardFooterInteractionBar(
            userId: userId,
            postType: postType,
            likeCount: likeCount,
            commentCount: commentCount,
            shareCount: shareCount,
            useInReviewCard: useInReviewCard,
            cardType: cardType,
            fullscreen: fullscreen,
            postId: postId,
          ),
        ),
        Divider(height: 16.h, thickness: 1.h, color: ColorManager.dividerGrey),
        Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: CardFooterButtonBar(
            liked: liked,
            useInReviewCard: useInReviewCard,
            onLike: onLike,
            onComment: onComment,
            onShare: onShare,
            postId: postId,
            postType: postType,
            userId: userId,
            postForReportCard: postForReportCard,
          ),
        )
      ],
    );
  }
}
