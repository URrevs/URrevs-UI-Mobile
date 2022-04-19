import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer_interaction_item.dart';

/// Part of a card footer. Contains statistics about users interaction with the
/// card. It contains number of likes, comments and shares.
class CardFooterInteractionBar extends StatelessWidget {
  const CardFooterInteractionBar({
    Key? key,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.useInReviewCard,
  }) : super(key: key);

  /// Number of likes given to the review.
  final int likeCount;

  /// Number of comments on the review.
  final int commentCount;

  /// Number of shares to the review
  final int shareCount;

  /// Whether the [CardFooterInteractionBar] would be used in a review card or
  /// not.
  final bool useInReviewCard;

  @override
  Widget build(BuildContext context) {
    IconData firstIcon = useInReviewCard ? Icons.thumb_up : Icons.arrow_upward;

    return Row(
      children: [
        CardFooterInteractionItem(
          text: likeCount.toString(),
          iconData: firstIcon,
        ),
        Spacer(),
        CardFooterInteractionItem(
          text: commentCount.toString(),
          iconData: Icons.comment,
        ),
        7.horizontalSpace,
        CardFooterInteractionItem(
          text: shareCount.toString(),
          iconData: Icons.share,
        ),
      ],
    );
  }
}
