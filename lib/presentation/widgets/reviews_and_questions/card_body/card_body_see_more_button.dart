import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Returns see more button.
class CardBodySeeMoreButton extends StatelessWidget {
  const CardBodySeeMoreButton({
    Key? key,
    required this.expanded,
    required this.prosAndConsCut,
    required this.setExpandedState,
    required this.noNeedForExpansion,
    required this.hideSeeMoreIfNoNeedForExpansion,
  }) : super(key: key);

  /// Whether the card is expanded or not.
  final bool expanded;

  /// Returns a boolean value representing whether the whole pros and cons texts
  /// are shown or substrings of them.
  final bool prosAndConsCut;

  /// If set to true, [CardBodySeeMoreButton] would be hidden at the state of
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
  final void Function(bool) setExpandedState;

  /// Decide what would be shown on the [TextButton] shown after pros & cons
  /// section:
  /// * `see more` would be shown if:
  ///   * The card is collapsed.
  ///   * The pros and cons sections are not completely show even after
  ///     expansion.
  /// * `see less` would be shown if the card is expanded and pros and cons
  ///   sections are completely shown.
  String get seeMoreButtonText {
    if (!expanded) {
      return LocaleKeys.seeMore.tr();
    } else if (!prosAndConsCut) {
      return LocaleKeys.seeLess.tr();
    } else {
      return LocaleKeys.seeMore.tr();
    }
  }

  /// Invoked when user presses on see more button.
  /// * If the review card is collapsed, expand it.
  /// * If the review card is expanded:
  ///   * If the pros and cons text is completely shown, collapse the card.
  ///   * If the pros and cons text is not completely shown, go to fullscreen
  ///     review screen.
  void _onPressingSeeMore() {
    if (!expanded) {
      return setExpandedState(true);
    }
    if (!prosAndConsCut) {
      return setExpandedState(false);
    }
    // TODO: go to review full screen
  }

  @override
  Widget build(BuildContext context) {
    /// Adjust the alignment according to the locale.
    final Alignment alignment =
        context.locale.countryCode == LanguageType.en.name
            ? Alignment.centerLeft
            : Alignment.centerRight;

    if (hideSeeMoreIfNoNeedForExpansion && noNeedForExpansion) {
      return Container();
    }

    return TextButton(
      style: TextButton.styleFrom(
        primary: ColorManager.black,
        padding: EdgeInsets.all(0),
        alignment: alignment,
      ),
      onPressed: _onPressingSeeMore,
      child: Text(seeMoreButtonText),
    );
  }
}
