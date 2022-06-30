import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_body_text.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_body_title.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_like_counter.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/send_report_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class InteractionBody extends ConsumerStatefulWidget {
  const InteractionBody({
    Key? key,
    required this.authorName,
    required this.authorId,
    required this.replyText,
    required this.likeCount,
    required this.maxWidth,
    required this.inQuestionCard,
    required this.interactionType,
    this.usedSinceDate,
    this.onTappingAnswerInCard,
    required this.interactionId,
    required this.postContentType,
    required this.targetType,
    required this.parentPostId,
    required this.parentDirectInteractionId,
  })  : assert(
          !inQuestionCard || onTappingAnswerInCard != null,
          'onTappingAnswerInCard cannot be null if inQuestionCard is true.',
        ),
        super(key: key);

  final String authorName;
  final String authorId;
  final String replyText;
  final int likeCount;
  final double maxWidth;
  final bool inQuestionCard;
  final DateTime? usedSinceDate;
  final VoidCallback? onTappingAnswerInCard;
  final InteractionType interactionType;

  final String interactionId;
  final PostContentType postContentType;
  final TargetType targetType;
  final String? parentPostId;
  final String? parentDirectInteractionId;

  @override
  ConsumerState<InteractionBody> createState() => _InteractionBodyState();
}

class _InteractionBodyState extends ConsumerState<InteractionBody> {
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

  bool get isAnswer => widget.interactionType == InteractionType.answer;

  late final ReportProviderParams _reportPostProviderParams =
      ReportProviderParams(
    socialItemId: widget.interactionId,
    postContentType: widget.postContentType,
    targetType: widget.targetType,
    interactionType: widget.interactionType,
    parentDirectInteractionId: widget.parentDirectInteractionId,
    parentPostId: widget.parentPostId,
  );

  void _setExpandedState(bool val) => setState(() => _expanded = val);

  void _onTappingReplyBody() {
    if (!widget.inQuestionCard) {
      _setExpandedState(!_expanded);
      return;
    }
    widget.onTappingAnswerInCard!();
  }

  void _onHoldingInteractionBody() {
    ShapeBorder shapeBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.r),
        topRight: Radius.circular(12.r),
      ),
    );
    showModalBottomSheet(
      context: context,
      shape: shapeBorder,
      builder: (context) => ListTile(
        onTap: () {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) => SendReportDialog(
              socialItemId: widget.interactionId,
              postContentType: widget.postContentType,
              targetType: widget.targetType,
              parentPostId: widget.parentPostId,
              parentDirectInteractionId: widget.parentDirectInteractionId,
              interactionType: widget.interactionType,
            ),
          );
        },
        title: Text(
          LocaleKeys.report.tr(),
          style: TextStyleManager.s16w700.copyWith(color: ColorManager.black),
        ),
        shape: shapeBorder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: reportPostProvider(_reportPostProviderParams),
      context: context,
    );
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
          elevation: AppElevations.ev1,
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppRadius.interactionBodyRadius),
          ),
          color: widget.inQuestionCard
              ? ColorManager.backgroundGrey
              : ColorManager.white,
          child: InkWell(
            onTap: noNeedForExpansion ? null : _onTappingReplyBody,
            onLongPress: _onHoldingInteractionBody,
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
                  InteractionBodyTitle(
                    authorName: widget.authorName,
                    authorId: widget.authorId,
                  ),
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
          child: InteractionLikeCounter(
            likeCount: widget.likeCount,
            inQuestionCard: widget.inQuestionCard,
            isLike: !isAnswer,
          ),
        )
      ],
    );
  }
}
