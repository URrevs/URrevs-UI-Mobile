import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_body_text.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_body_title.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_like_counter.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class InteractionBody extends StatefulWidget {
  const InteractionBody({
    Key? key,
    required this.authorName,
    required this.replyText,
    required this.likeCount,
    required this.maxWidth,
    required this.inQuestionCard,
    this.usedSinceDate,
    this.onTappingAnswerInCard,
  })  : assert(
          !inQuestionCard || onTappingAnswerInCard != null,
          'onTappingAnswerInCard cannot be null if inQuestionCard is true.',
        ),
        super(key: key);

  final String authorName;
  final String replyText;
  final int likeCount;
  final double maxWidth;
  final bool inQuestionCard;
  final DateTime? usedSinceDate;
  final VoidCallback? onTappingAnswerInCard;

  @override
  State<InteractionBody> createState() => _InteractionBodyState();
}

class _InteractionBodyState extends State<InteractionBody> {
  bool _expanded = false;

  /// Returns a boolean value representing whether the whole question text
  /// us shown or substrings of it.
  bool get textCut =>
      widget.replyText.length > AppNumericValues.interactionsMaxLetters;

  /// Returns true when the card is at a state in which we don't need to make
  /// an expansion. This state is when the question text
  /// length is less than or equal collapsedMaxLetters.
  bool get noNeedForExpansion =>
      widget.replyText.length <= AppNumericValues.interactionsMaxLetters;

  void _setExpandedState(bool val) => setState(() => _expanded = val);

  void _onTappingReplyBody() {
    if (!widget.inQuestionCard) {
      _setExpandedState(!_expanded);
      return;
    }
    widget.onTappingAnswerInCard!();
  }

  @override
  Widget build(BuildContext context) {
    String? usedSinceStr;
    if (widget.usedSinceDate != null) {
      usedSinceStr = LocaleKeys.usedThisProductFor.tr() +
          ' ' +
          timeago.format(
            widget.usedSinceDate!,
            locale: context.locale.languageCode,
          );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 1,
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppRadius.interactionBodyRadius),
          ),
          color: ColorManager.white,
          child: InkWell(
            onTap: noNeedForExpansion ? null : _onTappingReplyBody,
            borderRadius:
                BorderRadius.circular(AppRadius.interactionBodyRadius),
            child: Container(
              padding: EdgeInsets.only(
                top: 8.h,
                left: 12.w,
                right: 12.w,
                bottom: 16.h,
              ),
              constraints: BoxConstraints(maxWidth: widget.maxWidth),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppRadius.interactionBodyRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InteractionBodyTitle(authorName: widget.authorName),
                  if (usedSinceStr != null)
                    Text(
                      usedSinceStr,
                      style: TextStyleManager.s12w400.copyWith(
                        color: ColorManager.grey,
                      ),
                    ),
                  InteractionBodyText(
                    interactionText: widget.replyText,
                    expanded: _expanded,
                    setExpandedState: _setExpandedState,
                    inQuestionCard: widget.inQuestionCard,
                    onTappingAnswerInCard: widget.onTappingAnswerInCard,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: context.isArabic ? -16.w : null,
          right: context.isArabic ? null : -16.w,
          bottom: -9.h,
          child: InteractionLikeCounter(likeCount: widget.likeCount),
        )
      ],
    );
  }
}
