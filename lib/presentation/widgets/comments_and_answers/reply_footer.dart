import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

enum InteractionFooterFirstButtonText { like, vote, acceptAnswer }

class ReplyFooter extends StatelessWidget {
  const ReplyFooter({
    Key? key,
    required this.datePosted,
    required this.maxWidth,
    required this.liked,
    required this.firstButtonType,
  }) : super(key: key);

  final DateTime datePosted;
  final double maxWidth;
  final bool liked;
  final InteractionFooterFirstButtonText firstButtonType;

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

  @override
  Widget build(BuildContext context) {
    EdgeInsets footerElementsPadding =
        EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w);
    Color firstButtonColor = liked ? ColorManager.blue : ColorManager.black;

    var textButtonThemeData = TextButtonThemeData(
      style: Theme.of(context).textButtonTheme.style!.copyWith(
            textStyle: MaterialStateProperty.all(
              TextStyleManager.s13w700,
            ),
            foregroundColor: MaterialStateProperty.all(
              ColorManager.black,
            ),
            minimumSize: MaterialStateProperty.all(Size.zero),
            padding: MaterialStateProperty.all(
              footerElementsPadding,
            ),
          ),
    );
    return TextButtonTheme(
      data: textButtonThemeData,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          10.horizontalSpace,
          TextButton(
            onPressed: () {},
            style: textButtonThemeData.style!.copyWith(
              foregroundColor: MaterialStateProperty.all(firstButtonColor),
            ),
            child: Text(firstButtonText),
          ),
          20.horizontalSpace,
          TextButton(
            onPressed: () {},
            child: Text(LocaleKeys.reply.tr()),
          ),
          20.horizontalSpace,
          Padding(
            padding: footerElementsPadding,
            child: Text(
              timeago.format(datePosted, locale: context.locale.languageCode),
              style: TextStyleManager.s13w400.copyWith(
                color: ColorManager.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
