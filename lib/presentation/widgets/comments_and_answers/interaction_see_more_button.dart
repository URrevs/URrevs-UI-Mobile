import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Returns see more button.
class InteractionSeeMoreButton extends StatelessWidget {
  const InteractionSeeMoreButton({
    Key? key,
    required this.expanded,
    required this.parentTextCut,
    required this.setExpandedState,
    required this.noNeedForExpansion,
  }) : super(key: key);

  /// Whether the card is expanded or not.
  final bool expanded;

  /// Returns a boolean value representing whether the whole parent text
  /// are shown or substrings of it.
  final bool parentTextCut;

  /// A function that is invoked to set the expanded state of the parent.
  final void Function(bool) setExpandedState;

  /// Returns true when the card is at a state in which we don't need to make
  /// an expansion. This state is when the sum of pros text length and cons text
  /// length is less than or equal collapsedMaxLetters.
  final bool noNeedForExpansion;

  /// Decide what would be shown on the [TextButton] shown after the parent text
  /// * `see more` would be shown if parent text is cut.
  /// * `see less` would be shown otherwise.
  String get seeMoreButtonText {
    if (parentTextCut) {
      return LocaleKeys.seeMore.tr();
    } else {
      return LocaleKeys.seeLess.tr();
    }
  }

  /// Invoked when user presses on see more button.
  /// Toggles the state of the parent card.
  void _onPressingSeeMore() {
    setExpandedState(!expanded);
  }

  @override
  Widget build(BuildContext context) {
    if (expanded || noNeedForExpansion) {
      return SizedBox();
    }

    return TextButton(
      style: TextButton.styleFrom(
        primary: ColorManager.black,
        minimumSize: Size.zero,
        padding: EdgeInsets.all(0),
      ),
      onPressed: _onPressingSeeMore,
      child: Text(seeMoreButtonText, style: TextStyleManager.s16w800),
    );
  }
}
