import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Returns see more button.
class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    Key? key,
    required this.expanded,
    required this.parentTextCut,
    required this.setExpandedState,
    required this.noNeedForExpansion,
    required this.hideSeeMoreIfNoNeedForExpansion,
    required this.usedInInteraction,
  }) : super(key: key);

  /// Whether the card is expanded or not.
  final bool expanded;

  /// Returns a boolean value representing whether the whole parent text
  /// are shown or substrings of it.
  final bool parentTextCut;

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

  /// Whether the see more button would be used in an interaction (comment,
  /// answer, reply) or a post (review, question)
  final bool usedInInteraction;

  /// A function that is invoked to set the expanded state of the parent.
  final void Function(bool) setExpandedState;

  /// Decide what would be shown on the [TextButton] shown after pros & cons
  /// section:
  /// * `see more` would be shown if:
  ///   * Used in an interaction (comment, answer, reply).
  ///   * Used in a post (review, question) and the card is collapsed.
  ///   * Used in a post and post text is not completely show even after
  ///     expansion.
  /// * `see less` would be shown if the button is used in a post and the post
  /// card is expanded while post text is completely shown.
  String get seeMoreButtonText {
    if (usedInInteraction) {
      return LocaleKeys.seeMore.tr();
    }
    if (expanded && !parentTextCut) {
      return LocaleKeys.seeLess.tr();
    } else {
      return LocaleKeys.seeMore.tr();
    }
  }

  /// Invoked when user presses on see more button.
  /// * If [usedInInteraction], toggle [expanded] state.
  /// * If the review card is collapsed, expand it.
  /// * If the review card is expanded:
  ///   * If the pros and cons text is completely shown, collapse the card.
  ///   * If the pros and cons text is not completely shown, go to fullscreen
  ///     review screen.
  void _onPressingSeeMore() {
    if (usedInInteraction) {
      return setExpandedState(!expanded);
    }
    if (!expanded) {
      return setExpandedState(true);
    }
    if (!parentTextCut) {
      return setExpandedState(false);
    }
    // TODO: go to review full screen
  }

  @override
  Widget build(BuildContext context) {
    bool hideSeemore =
        (hideSeeMoreIfNoNeedForExpansion && noNeedForExpansion) ||
            (usedInInteraction && expanded);
    if (hideSeemore) {
      return SizedBox();
    }

    return TextButton(
      style: TextButtonStyleManager.seeMoreButton,
      onPressed: _onPressingSeeMore,
      child: Text(
        seeMoreButtonText,
        style: usedInInteraction
            ? TextStyleManager.s15w700
            : TextStyleManager.s16w700,
      ),
    );
  }
}
