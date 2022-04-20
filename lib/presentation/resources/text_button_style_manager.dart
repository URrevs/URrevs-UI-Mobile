import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';

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
}
