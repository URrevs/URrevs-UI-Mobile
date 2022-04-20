import 'package:flutter/cupertino.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class InteractionBodyText extends StatelessWidget {
  const InteractionBodyText({
    Key? key,
    required this.interactionText,
  }) : super(key: key);

  final String interactionText;

  @override
  Widget build(BuildContext context) {
    return Text(
      interactionText,
      style: TextStyleManager.s14w400.copyWith(
        color: ColorManager.commentBlack,
      ),
      softWrap: true,
    );
  }
}
