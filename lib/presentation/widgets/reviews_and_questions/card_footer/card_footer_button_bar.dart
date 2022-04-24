import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer_button.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// The three bottom buttons of the card footer.
class CardFooterButtonBar extends StatelessWidget {
  const CardFooterButtonBar({
    Key? key,
    required this.liked,
    required this.useInReviewCard,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  }) : super(key: key);

  /// Is the review liked by the current logged in user or not.
  final bool liked;

  /// Whether the [CardFooterButtonBar] would be used in a review card or
  /// not.
  final bool useInReviewCard;

  /// Callback invoked when like (or upvote) buttons are pressed.
  final VoidCallback onLike;

  /// Callback invoked when comment (or answer) buttons are pressed.
  final VoidCallback onComment;

  /// Callback invoked when share button is pressed.
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    String likedText = liked ? LocaleKeys.liked.tr() : LocaleKeys.like.tr();

    Color buttonColor = (liked) ? ColorManager.blue : ColorManager.buttonGrey;

    Widget firstIcon = useInReviewCard
        ? Icon(
            Icons.thumb_up_alt_outlined,
            size: 23.sp,
            color: buttonColor,
          )
        : FaIcon(
            FontAwesomeIcons.upLong,
            size: 23.sp,
            color: buttonColor,
          );

    String firstText = useInReviewCard ? likedText : LocaleKeys.vote.tr();
    String secondText =
        useInReviewCard ? LocaleKeys.comment.tr() : LocaleKeys.answer.tr();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CardFooterButton(
          icon: firstIcon,
          text: firstText,
          liked: liked,
          onPressed: onLike,
        ),
        CardFooterButton(
          icon: Icon(Icons.mode_comment_outlined),
          text: secondText,
          onPressed: onComment,
        ),
        CardFooterButton(
          icon: Icon(Icons.share_outlined),
          text: LocaleKeys.share.tr(),
          onPressed: onShare,
        ),
      ],
    );
  }
}
