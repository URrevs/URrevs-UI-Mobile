import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_footer_interaction_item.dart';

/// Part of a card footer. Contains statistics about users interaction with the
/// card. It contains number of likes, comments and shares.
class CardFooterInteractionBar extends StatelessWidget {
  const CardFooterInteractionBar({
    Key? key,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
  }) : super(key: key);

  final int likeCount;
  final int commentCount;
  final int shareCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CardFooterInteractionItem(
          text: likeCount.toString(),
          iconData: Icons.thumb_up,
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
