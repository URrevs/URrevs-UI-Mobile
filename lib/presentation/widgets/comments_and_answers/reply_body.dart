import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/interaction_body_text.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/interaction_body_title.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/interaction_like_counter.dart';

class ReplyBody extends StatefulWidget {
  const ReplyBody({
    Key? key,
    required this.authorName,
    required this.replyText,
    required this.likeCount,
    required this.maxWidth,
  }) : super(key: key);

  final String authorName;
  final String replyText;
  final int likeCount;
  final double maxWidth;

  @override
  State<ReplyBody> createState() => _ReplyBodyState();
}

class _ReplyBodyState extends State<ReplyBody> {
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

  @override
  Widget build(BuildContext context) {
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
            onTap: () => _setExpandedState(!_expanded),
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
                  InteractionBodyText(
                    interactionText: widget.replyText,
                    expanded: _expanded,
                    setExpandedState: _setExpandedState,
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
