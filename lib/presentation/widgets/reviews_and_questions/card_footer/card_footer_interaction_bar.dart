import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
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
    Widget firstIcon = useInReviewCard
        ? Icon(
            Icons.thumb_up_alt_outlined,
            size: 16.sp,
            color: ColorManager.grey,
          )
        : FaIcon(
            FontAwesomeIcons.upLong,
            size: 16.sp,
            color: ColorManager.grey,
          );

    NumberFormat numberFormat =
        NumberFormat.compact(locale: context.locale.languageCode);

    return Row(
      children: [
        CardFooterInteractionItem(
          text: numberFormat.format(likeCount),
          icon: firstIcon,
        ),
        Spacer(),
        CardFooterInteractionItem(
          text: numberFormat.format(commentCount),
          icon: Icon(
            Icons.mode_comment_outlined,
            size: 16.sp,
            color: ColorManager.grey,
          ),
        ),
        8.horizontalSpace,
        CardFooterInteractionItem(
          text: numberFormat.format(shareCount),
          icon: Icon(
            Icons.share_outlined,
            size: 16.sp,
            color: ColorManager.grey,
          ),
        ),
      ],
    );
  }
}
