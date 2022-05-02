import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    Key? key,
    required this.dateController,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController dateController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      readOnly: true,
      controller: dateController,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2222))
            .then((date) {
          dateController.text = DateFormat("EEE, d / M /y").format(date!);
        });
      },
      style: TextStyleManager.s20w500.copyWith(
        color: ColorManager.black,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.backgroundGrey),
            borderRadius: BorderRadius.circular(5.r)),
        hintText: hintText,
        hintStyle: TextStyleManager.s16w300.copyWith(color: ColorManager.black),
        filled: true,
        fillColor: ColorManager.textFieldGrey,
        suffixIcon: Icon(
          IconsManager.expand,
          size: 32.sp,
        ),
        suffixIconColor: ColorManager.black,
      ),
    );
  }
}
