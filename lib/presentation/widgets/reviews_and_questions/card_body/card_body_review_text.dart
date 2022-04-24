import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/see_more_button.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Returns the block containing the pros and cons text.
class CardBodyReviewText extends StatelessWidget {
  const CardBodyReviewText({
    Key? key,
    required this.prosText,
    required this.consText,
    required this.maxLetters,
    required this.expanded,
    required this.prosAndConsCut,
    required this.setExpandedState,
    required this.noNeedForExpansion,
    required this.hideSeeMoreIfNoNeedForExpansion,
  }) : super(key: key);

  /// The text which the user written in the pros section when submitting the
  /// review.
  final String prosText;

  /// The text which the user written in the cons section when submitting the
  /// review.
  final String consText;

  /// The max letters limit applied at any moment to the review card.
  /// It is based on the expanded condition of the review card.
  final int maxLetters;

  /// Whether the card is expanded or not.
  final bool expanded;

  /// Returns a boolean value representing whether the whole pros and cons texts
  /// are shown or substrings of them.
  final bool prosAndConsCut;

  /// If set to true, [SeeMoreButton] would be hidden at the state of
  /// the card where both pros and cons text are both shown completely. This
  /// case only occurs when the the sum of pros text length and cons text length
  /// is less than or equal to collapsedMaxLetters.
  ///
  /// This is set to true at the case of company review card.
  final bool hideSeeMoreIfNoNeedForExpansion;

  /// Returns true when the card is at a state in which we don't need to make
  /// an expansion. This state is when the sum of pros text length and cons text
  /// length is less than or equal collapsedMaxLetters.
  final bool noNeedForExpansion;

  /// A function that is invoked to set the expanded state of the parent.
  final void Function(bool) setExpandedState;

  /// Cut the pros text according to the expanded state and [maxLetters] of
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
          LocaleKeys.pros.tr() + ':',
          style: TextStyleManager.s18w500,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: cutPros(prosText),
                style: TextStyleManager.s16w400.copyWith(
                  color: ColorManager.black,
                ),
              ),
              if (!showCons)
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: SeeMoreButton(
                    expanded: expanded,
                    parentTextCut: prosAndConsCut,
                    setExpandedState: setExpandedState,
                    noNeedForExpansion: noNeedForExpansion,
                    hideSeeMoreIfNoNeedForExpansion:
                        hideSeeMoreIfNoNeedForExpansion,
                    usedInInteraction: false,
                  ),
                )
            ],
          ),
        ),
        if (showCons)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              Text(
                LocaleKeys.cons.tr() + ':',
                style: TextStyleManager.s18w500,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: cutCons(consText),
                      style: TextStyleManager.s16w400.copyWith(
                        color: ColorManager.black,
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: SeeMoreButton(
                        expanded: expanded,
                        parentTextCut: prosAndConsCut,
                        setExpandedState: setExpandedState,
                        noNeedForExpansion: noNeedForExpansion,
                        hideSeeMoreIfNoNeedForExpansion:
                            hideSeeMoreIfNoNeedForExpansion,
                        usedInInteraction: false,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
