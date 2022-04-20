import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
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

    IconData firstIcon = useInReviewCard ? Icons.thumb_up : Icons.arrow_upward;

    String firstText = useInReviewCard ? likedText : LocaleKeys.vote.tr();
    String secondText =
        useInReviewCard ? LocaleKeys.comment.tr() : LocaleKeys.answer.tr();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CardFooterButton(
          iconData: firstIcon,
          text: firstText,
          liked: liked,
          onPressed: onLike,
        ),
        CardFooterButton(
          iconData: Icons.comment,
          text: secondText,
          onPressed: onComment,
        ),
        CardFooterButton(
          iconData: Icons.share,
          text: LocaleKeys.share.tr(),
          onPressed: onShare,
        ),
      ],
    );
  }
}