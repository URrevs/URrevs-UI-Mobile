import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/card_body_question_text.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/see_more_button.dart';

/// Middle block of the review card.
/// Contains star ratings and pros and cons of the product.
class QuestionCardBody extends StatefulWidget {
  const QuestionCardBody({
    Key? key,
    required this.questionText,
  }) : super(key: key);

  /// Question text viewed by the card.
  final String questionText;

  @override
  State<QuestionCardBody> createState() => _QuestionCardBodyState();
}

class _QuestionCardBodyState extends State<QuestionCardBody> {
  /// Whether the card is expanded or not.
  bool _expanded = false;

  /// The max letters limit applied at any moment to the review card.
  /// It is based on the [_expanded] condition of the review card.
  int get maxLetters => _expanded
      ? AppNumericValues.expandedMaxLetters
      : AppNumericValues.collapsedMaxLetters;

  /// Returns a boolean value representing whether the whole question text
  /// us shown or substrings of it.
  bool get questionTextCut => widget.questionText.length > maxLetters;

  /// Returns true when the card is at a state in which we don't need to make
  /// an expansion. This state is when the question text
  /// length is less than or equal collapsedMaxLetters.
  bool get noNeedForExpansion =>
      widget.questionText.length <= AppNumericValues.collapsedMaxLetters;

  void setExpandedState(bool value) {
    setState(() {
      _expanded = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: noNeedForExpansion
          ? null
          : () => setState(() {
                _expanded = !_expanded;
              }),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardBodyQuestionText(
              questionText: widget.questionText,
              expanded: _expanded,
              setExpandedState: setExpandedState,
            ),
            SeeMoreButton(
              expanded: _expanded,
              parentTextCut: questionTextCut,
              setExpandedState: setExpandedState,
              noNeedForExpansion: noNeedForExpansion,
              hideSeeMoreIfNoNeedForExpansion: true,
              usedInInteraction: false,
            )
          ],
        ),
      ),
    );
  }
}
