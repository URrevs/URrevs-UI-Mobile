import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer_button_bar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer_interaction_bar.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

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
  }) : super(key: key);

  /// Is the review liked by the current logged in user or not.
  final bool liked;

  /// Number of likes given to the review.
  final int likeCount;

  /// Number of comments on the review.
  final int commentCount;

  /// Number of shares to the review
  final int shareCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CardFooterInteractionBar(
            likeCount: likeCount,
            commentCount: commentCount,
            shareCount: shareCount,
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CardFooterButtonBar(liked: liked),
        )
      ],
    );
  }
}
