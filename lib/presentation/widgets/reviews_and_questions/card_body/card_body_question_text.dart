import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/see_more_button.dart';

/// Returns the block containing the pros and cons text.
class CardBodyQuestionText extends StatelessWidget {
  const CardBodyQuestionText({
    Key? key,
    required this.questionText,
    required this.expanded,
    required this.setExpandedState,
  }) : super(key: key);

  /// The question written by the user
  final String questionText;

  /// Whether the card is expanded or not.
  final bool expanded;


  /// A function that is invoked to set the expanded state of the parent.
  final void Function(bool) setExpandedState;

  /// If true, the received text would be cut if its length exceeds [maxLetters]
  // final bool cutTextIfExceededLimit;
  
  /// Returns true when the card is at a state in which we don't need to make
  /// an expansion. This state is when the question text
  /// length is less than or equal collapsedMaxLetters.
  bool get noNeedForExpansion =>
      questionText.length <= AppNumericValues.collapsedMaxLetters;

  /// The max letters limit applied at any moment to the review card.
  /// It is based on the [_expanded] condition of the review card.
  int get maxLetters => expanded
      ? AppNumericValues.expandedMaxLetters
      : AppNumericValues.collapsedMaxLetters;

  /// Returns a boolean value representing whether the whole question text
  /// us shown or substrings of it.
  bool get questionTextCut => questionText.length > maxLetters;

  /// Cut the question text according to the expanded state and [maxLetters] of
  /// the review card.
  ///
  /// We would take a substring of the question text if its length is more than
  /// the maximum limit of letters specifed by [maxLetters].
  ///
  /// We would return the pros text as it is if its length is less than or equal
  /// to [maxLetters].
  ///
  /// Different from pros text in the review card in the case where the length
  /// of question text is equal to the [maxLetters], in the case of question
  /// text, the question is written without the three dots after it, while in
  /// the case of pros text, the pros text is written with the three dots after
  /// it so that the user know about the cons section that follows the pros
  /// section.
  String cutQuestionText(String qText) {
    if (qText.length > maxLetters) {
      String substr = qText.substring(0, maxLetters);
      return substr + "...";
    }
    return qText;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: [
          TextSpan(
            text: cutQuestionText(questionText),
            style: TextStyleManager.s16w400.copyWith(
              color: ColorManager.black,
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: SeeMoreButton(
              expanded: expanded,
              parentTextCut: questionTextCut,
              setExpandedState: setExpandedState,
              noNeedForExpansion: noNeedForExpansion,
              hideSeeMoreIfNoNeedForExpansion:
                  true,
              usedInInteraction: false,
            ),
          )
        ],
      ),
    );
  }
}
