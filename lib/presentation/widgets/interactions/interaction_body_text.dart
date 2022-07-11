import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/see_more_button.dart';
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

  bool get exceedingLineBreakLimit {
    int lineBreaks = interactionText.split('').fold<int>(0, (total, char) {
      if (char == '\n') return total + 1;
      return total;
    });
    return lineBreaks >= AppNumericValues.interactionsMaxLines;
  }

  bool get interactionTextCut =>
      !expanded &&
      (interactionText.length > AppNumericValues.interactionsMaxLetters ||
          exceedingLineBreakLimit);

  bool get noNeedForExpansion =>
      interactionText.length <= AppNumericValues.interactionsMaxLetters &&
      !exceedingLineBreakLimit;

  String cutText(String text) {
    if (expanded) {
      return text;
    }
    if (indexOfLineBreakExceedingLimit != null) {
      String substr = text.substring(0, indexOfLineBreakExceedingLimit);
      return substr + "...";
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
      style: TextButtonStyleManager.seeMoreButton,
      onPressed: onTappingAnswerInCard,
      child: Text(seeMoreButtonText, style: TextStyleManager.s15w800),
    );
  }

  int? get indexOfLineBreakExceedingLimit {
    int lineBreaks = 0;
    for (int i = 0; i < interactionText.length; i++) {
      if (interactionText[i] == '\n') lineBreaks++;
      if (lineBreaks == AppNumericValues.interactionsMaxLines) return i;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: cutText(interactionText),
            style: TextStyleManager.s15w400.copyWith(
              color: ColorManager.commentBlack,
              height: FontHeightManager.post,
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: inQuestionCard
                ? _buildSpecialAnswerSeeMoreButton()
                : SeeMoreButton(
                    expanded: expanded,
                    parentTextCut: interactionTextCut,
                    setExpandedState: setExpandedState,
                    noNeedForExpansion: noNeedForExpansion,
                    hideSeeMoreIfNoNeedForExpansion: true,
                    usedInInteraction: true,
                    cardType: CardType.reply,
                    postId: null,
                    postType: null,
                    postUserId: null,
                  ),
          ),
        ],
      ),
    );
  }
}
