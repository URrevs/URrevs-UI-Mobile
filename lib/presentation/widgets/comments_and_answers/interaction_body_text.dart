import 'package:flutter/cupertino.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/interaction_see_more_button.dart';

class InteractionBodyText extends StatelessWidget {
  const InteractionBodyText({
    Key? key,
    required this.interactionText,
    required this.expanded,
    required this.setExpandedState,
  }) : super(key: key);

  final String interactionText;
  final bool expanded;

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
            child: InteractionSeeMoreButton(
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
