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
  }) : super(key: key);

  final bool expanded;
  final bool prosAndConsCut;

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

  @override
  Widget build(BuildContext context) {
    /// Adjust the alignment according to the locale.
    final Alignment alignment =
        context.locale.countryCode == LanguageType.en.name
            ? Alignment.centerLeft
            : Alignment.centerRight;

    return TextButton(
      style: TextButton.styleFrom(
        primary: ColorManager.black,
        padding: EdgeInsets.all(0),
        alignment: alignment,
      ),
      onPressed: () {},
      child: Text(seeMoreButtonText),
    );
  }
}
