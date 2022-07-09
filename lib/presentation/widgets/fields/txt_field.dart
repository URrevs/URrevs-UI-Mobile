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
    this.maxLines,
    this.textInputAction,
    this.errorMaxLines = 1,
    this.validator,
  }) : super(key: key);

  final TextEditingController textController;
  final String hintText;
  final TextInputType keyboardType;
  final Color fillColor;
  final String errorMsg;
  final bool hasErrorMsg;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final String? Function(String)? extraValidation;
  final int errorMaxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final InputBorder inputBorder = OutlineInputBorder(
        borderSide: BorderSide(width: 0.8, color: ColorManager.backgroundGrey),
        borderRadius: BorderRadius.circular(5.r));
    return TextFormField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      keyboardAppearance: Brightness.dark,
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
        errorMaxLines: errorMaxLines,
        errorStyle: TextStyleManager.s13w400.copyWith(color: ColorManager.red),
        errorBorder: hasErrorMsg
            ? inputBorder.copyWith(
                borderSide: BorderSide(color: ColorManager.red))
            : inputBorder,
      ),
      validator: hasErrorMsg
          ? (value) {
              if (validator != null) {
                return validator!(value);
              }
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
