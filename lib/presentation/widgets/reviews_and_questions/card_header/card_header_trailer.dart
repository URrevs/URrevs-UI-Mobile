import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Builds the trailing part of the header.
/// It contains a [PopupMenuButton] that shows "I don't like this"
class CardHeaderTrailer extends StatelessWidget {
  const CardHeaderTrailer({Key? key, required this.onHatingThis})
      : super(key: key);

  /// A callback executed when the user presses on "I don't like this".
  final VoidCallback onHatingThis;

  void _onHatingThis(dynamic _) => onHatingThis();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: _onHatingThis,
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(child: Text(LocaleKeys.iDontLikeThis.tr())),
      ],
      child: Icon(Icons.more_vert),
    );
  }
}
