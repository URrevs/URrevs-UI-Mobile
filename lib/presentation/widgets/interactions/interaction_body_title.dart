import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class InteractionBodyTitle extends StatelessWidget {
  const InteractionBodyTitle({
    Key? key,
    required this.authorName,
  }) : super(key: key);

  final String authorName;

  @override
  Widget build(BuildContext context) {
    return Text(
      authorName,
      style: TextStyleManager.s15w700,
    );
  }
}
