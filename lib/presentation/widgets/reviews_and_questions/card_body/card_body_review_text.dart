import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Returns the block containing the pros and cons text.
class CardBodyReviewText extends StatelessWidget {
  const CardBodyReviewText({
    Key? key,
    required this.prosText,
    required this.consText,
    required this.maxLetters,
  }) : super(key: key);

  /// The text which the user written in the pros section when submitting the
  /// review.
  final String prosText;

  /// The text which the user written in the cons section when submitting the
  /// review.
  final String consText;

  /// The max letters limit applied at any moment to the review card.
  /// It is based on the [_expanded] condition of the review card.
  final int maxLetters;

  /// Cut the pros text according to the [_expanded] state and [maxLetters] of
  /// the review card.
  ///
  /// We would take a substring of the pros text if its length is more than or
  /// equal to the maximum limit of letters specifed by [maxLetters].
  ///
  /// We would return the pros text as it is if its length is less than
  /// [maxLetters]
  String cutPros(String pros) {
    if (pros.length >= maxLetters) {
      String substr = pros.substring(0, maxLetters);
      return substr + "...";
    }
    return pros;
  }

  /// Cut the cons text according to the following rules:
  /// * Define a variable called remainingLetters which is the difference
  /// between the length of pros text and the allowed [maxLetters].
  /// * Return nothing the value of remainingLetters is less than or equal 0 (
  /// it would be less than 0 if pros text length is more than [maxLetters])
  /// * Return the cons text as it is if its length is less than
  /// remainingLetters value.
  /// * Return a substring of cons text if its length is greater than
  /// remainingLetters value.
  String cutCons(String cons) {
    int remainingLetters = maxLetters - prosText.length;
    if (remainingLetters <= 0) {
      return "";
    }
    if (cons.length > remainingLetters) {
      String substr = cons.substring(0, remainingLetters);
      return substr + "...";
    }
    return cons;
  }

  /// Returns a boolean value representing whether we should show cons section
  /// or not.
  bool get showCons => prosText.length < maxLetters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.pros.tr(),
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          cutPros(prosText),
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        if (showCons)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              Text(
                LocaleKeys.cons.tr(),
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                cutCons(consText),
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
      ],
    );
  }
}
