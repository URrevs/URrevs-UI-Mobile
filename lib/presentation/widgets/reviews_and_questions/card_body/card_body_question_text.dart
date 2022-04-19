import 'package:flutter/material.dart';

/// Returns the block containing the pros and cons text.
class CardBodyQuestionText extends StatelessWidget {
  const CardBodyQuestionText({
    Key? key,
    required this.questionText,
    required this.maxLetters,
  }) : super(key: key);

  /// The question written by the user
  final String questionText;

  /// The max letters limit applied at any moment to the review card.
  /// It is based on the expanded condition of the review card.
  final int maxLetters;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cutQuestionText(questionText),
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
