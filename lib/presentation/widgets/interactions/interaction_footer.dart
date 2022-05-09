import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

enum InteractionFooterFirstButtonText { like, vote, acceptAnswer }

class InteractionFooter extends StatelessWidget {
  const InteractionFooter({
    Key? key,
    required this.datePosted,
    required this.maxWidth,
    required this.liked,
    required this.firstButtonType,
    this.posting = false,
  }) : super(key: key);

  final DateTime datePosted;
  final double maxWidth;
  final bool liked;
  final InteractionFooterFirstButtonText firstButtonType;
  final bool posting;

  String get firstButtonText {
    switch (firstButtonType) {
      case InteractionFooterFirstButtonText.like:
        return liked ? LocaleKeys.liked.tr() : LocaleKeys.like.tr();
      case InteractionFooterFirstButtonText.vote:
        return LocaleKeys.vote.tr();
      case InteractionFooterFirstButtonText.acceptAnswer:
        return liked
            ? LocaleKeys.acceptedAnswer.tr()
            : LocaleKeys.acceptAnswer.tr();
    }
  }

  String footerText(BuildContext context) => posting
      ? LocaleKeys.posting.tr() + '...'
      : timeago.format(datePosted, locale: context.locale.languageCode);

  @override
  Widget build(BuildContext context) {
    EdgeInsets footerElementsPadding =
        EdgeInsets.only(top: 6.h, left: 3.w, right: 3.w);
    Color firstButtonColor = liked ? ColorManager.blue : ColorManager.black;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        10.horizontalSpace,
        if (!posting) ...[
          TextButton(
            onPressed: () {},
            style: TextButtonStyleManager.interactionFooterButton.copyWith(
              foregroundColor: MaterialStateProperty.all(firstButtonColor),
            ),
            child: Text(firstButtonText, style: TextStyleManager.s13w700),
          ),
          20.horizontalSpace,
          TextButton(
            onPressed: () {},
            style: TextButtonStyleManager.interactionFooterButton,
            child: Text(LocaleKeys.reply.tr(), style: TextStyleManager.s13w700),
          ),
          20.horizontalSpace,
        ],
        Padding(
          padding: footerElementsPadding,
          child: Text(
            footerText(context),
            style: TextStyleManager.s13w400.copyWith(
              color: ColorManager.grey,
            ),
          ),
        )
      ],
    );
  }
}
