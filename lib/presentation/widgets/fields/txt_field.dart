
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class TxtField extends StatelessWidget {
  const TxtField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.keyboardType
  }) : super(key: key);

  final TextEditingController textController;
  final String hintText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      cursorColor: ColorManager.black,
      textAlignVertical: TextAlignVertical.center,
      controller: textController,
      style: TextStyleManager.s20w500.copyWith(
        color: ColorManager.black,
      ),
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.backgroundGrey),
            borderRadius: BorderRadius.circular(5.r)),
        hintText: hintText,
        hintStyle:
            TextStyleManager.s16w300.copyWith(color: ColorManager.black),
        filled: true,
        fillColor: ColorManager.textFieldGrey,
      ),
    );
  }
}
