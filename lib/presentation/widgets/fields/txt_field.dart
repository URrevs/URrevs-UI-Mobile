import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class TxtField extends StatelessWidget {
  const TxtField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.keyboardType,
    required this.fillColor,
    this.errorMsg = '',
    this.hasErrorMsg = false,
    this.extraValidation,
  }) : super(key: key);

  final TextEditingController textController;
  final String hintText;
  final TextInputType keyboardType;
  final Color fillColor;
  final String errorMsg;
  final bool hasErrorMsg;
  final String? Function(String)? extraValidation;
  @override
  Widget build(BuildContext context) {
    final InputBorder inputBorder = OutlineInputBorder(
        borderSide: BorderSide(width: 0.8, color: ColorManager.backgroundGrey),
        borderRadius: BorderRadius.circular(5.r));
    return TextFormField(
      maxLines: null,
      keyboardType: keyboardType,
      cursorColor: ColorManager.black,
      textAlignVertical: TextAlignVertical.center,
      controller: textController,
      style: TextStyleManager.s20w500.copyWith(
        color: ColorManager.black,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        border: inputBorder,
        hintText: hintText,
        hintStyle: TextStyleManager.s16w300.copyWith(color: ColorManager.black),
        filled: true,
        fillColor: fillColor,
        errorStyle: TextStyleManager.s13w400.copyWith(color: ColorManager.red),
        errorBorder: hasErrorMsg
            ? inputBorder.copyWith(
                borderSide: BorderSide(color: ColorManager.red))
            : inputBorder,
      ),
      validator: hasErrorMsg
          ? (value) {
              if (value == null || value.isEmpty) {
                return errorMsg;
              } else if (extraValidation != null) {
                return extraValidation!(value);
              } else {
                return null;
              }
            }
          : null,
    );
  }
}
