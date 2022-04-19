import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer_button.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// The three bottom buttons of the card footer.
class CardFooterButtonBar extends StatelessWidget {
  const CardFooterButtonBar({
    Key? key,
    required this.liked,
  }) : super(key: key);

  /// Is the review liked by the current logged in user or not.
  final bool liked;

  @override
  Widget build(BuildContext context) {
    String likedText = liked ? LocaleKeys.liked.tr() : LocaleKeys.like.tr();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CardFooterButton(
          iconData: Icons.thumb_up,
          text: likedText,
          liked: liked,
          onPressed: () {},
        ),
        CardFooterButton(
          iconData: Icons.comment,
          text: LocaleKeys.comment.tr(),
          onPressed: () {},
        ),
        CardFooterButton(
          iconData: Icons.share,
          text: LocaleKeys.share.tr(),
          onPressed: () {},
        ),
      ],
    );
  }
}
