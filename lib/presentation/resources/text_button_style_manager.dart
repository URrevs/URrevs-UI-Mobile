import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class GeneralTextButtonStyleManager {
  static ButtonStyle get thinButton => TextButton.styleFrom(
        primary: ColorManager.black,
        minimumSize: Size.zero,
        padding: EdgeInsets.all(0),
      );
}

class TextButtonStyleManager {
  static ButtonStyle get showReplies =>
      GeneralTextButtonStyleManager.thinButton;
  static ButtonStyle get footerButton => TextButton.styleFrom(
        maximumSize: Size(double.infinity, double.infinity),
        primary: ColorManager.buttonGrey,
        textStyle: TextStyleManager.s16w700.copyWith(
          fontFamily: FontConstants.tajawal,
        ),
        padding: EdgeInsets.all(0),
      );
}
