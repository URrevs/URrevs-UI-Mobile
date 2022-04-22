import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/interaction_see_more_button.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class InteractionBodyText extends StatelessWidget {
  const InteractionBodyText({
    Key? key,
    required this.interactionText,
    required this.expanded,
    required this.setExpandedState,
    required this.inQuestionCard,
    required this.onTappingAnswerInCard,
  })  : assert(
          !inQuestionCard || onTappingAnswerInCard != null,
          'onTappingAnswerInCard cannot be null if inQuestionCard is true.',
        ),
        super(key: key);

  final String interactionText;
  final bool expanded;
  final bool inQuestionCard;
  final VoidCallback? onTappingAnswerInCard;

  /// A function that is invoked to set the expanded state of the parent.
  final void Function(bool) setExpandedState;

  bool get interactionTextCut =>
      !expanded &&
      interactionText.length > AppNumericValues.interactionsMaxLetters;

  bool get noNeedForExpansion =>
      interactionText.length <= AppNumericValues.interactionsMaxLetters;

  String cutText(String text) {
    if (expanded) {
      return text;
    }
    if (text.length > AppNumericValues.interactionsMaxLetters) {
      String substr =
          text.substring(0, AppNumericValues.interactionsMaxLetters);
      return substr + "...";
    }
    return text;
  }

  Widget _buildSpecialAnswerSeeMoreButton() {
    if (noNeedForExpansion) {
      return SizedBox();
    }

    String seeMoreButtonText =
        interactionTextCut ? LocaleKeys.seeMore.tr() : LocaleKeys.seeLess.tr();
    return TextButton(
      style: TextButton.styleFrom(
        primary: ColorManager.black,
        minimumSize: Size.zero,
        padding: EdgeInsets.all(0),
      ),
      onPressed: onTappingAnswerInCard,
      child: Text(seeMoreButtonText, style: TextStyleManager.s16w800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      softWrap: true,
      text: TextSpan(
        children: [
          TextSpan(
            text: cutText(interactionText),
            style: TextStyleManager.s14w400.copyWith(
              color: ColorManager.commentBlack,
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: inQuestionCard
                ? _buildSpecialAnswerSeeMoreButton()
                : InteractionSeeMoreButton(
                    expanded: expanded,
                    parentTextCut: interactionTextCut,
                    setExpandedState: setExpandedState,
                    noNeedForExpansion: noNeedForExpansion,
                  ),
          ),
        ],
      ),
    );
  }
}
