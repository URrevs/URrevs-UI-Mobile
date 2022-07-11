import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    Key? key,
    required this.dateController,
    required this.hintText,
    required this.fillColor,
    required this.isMonthDatePicker,
    required this.setChosenDate,
    this.errorMsg = '',
    this.hasErrorMsg = false,
  }) : super(key: key);

  final TextEditingController dateController;
  final String hintText;
  final Color fillColor;
  final bool isMonthDatePicker;
  final String errorMsg;
  final bool hasErrorMsg;
  final ValueChanged<DateTime> setChosenDate;

  @override
  Widget build(BuildContext context) {
    final InputBorder inputBorder = OutlineInputBorder(
        borderSide: BorderSide(width: 0.8, color: ColorManager.backgroundGrey),
        borderRadius: BorderRadius.circular(5.r));
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlignVertical: TextAlignVertical.center,
      readOnly: true,
      controller: dateController,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        if (!isMonthDatePicker) {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now().add(Duration(days: 1)),
            firstDate: DateTime.now().add(Duration(days: 1)),
            lastDate: DateTime(2222),
          );
          if (date == null) return;

          TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: 0, minute: 0),
          );
          if (time != null) {
            date = DateTime(
                date.year, date.month, date.day, time.hour, time.minute);
          }

          setChosenDate(date.toUtc());
          dateController.text = DateFormat(
            "EEE, d / M /y",
            Localizations.localeOf(context).toString(),
          ).addPattern('Hm', '   ').format(date);
        } else {
          showMonthPicker(
            context: context,
            firstDate: DateTime(2007, 6),
            lastDate: DateTime(DateTime.now().year, DateTime.now().month),
            initialDate: DateTime(DateTime.now().year, DateTime.now().month),
            locale: Localizations.localeOf(context),
          ).then((date) {
            if (date != null) {
              setChosenDate(date);
              dateController.text = DateFormat(
                "yMMMM",
                Localizations.localeOf(context).toString(),
              ).format(date);
            }
          });
        }
      },
      style: TextStyleManager.s20w500.copyWith(
        color: ColorManager.black,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        border: inputBorder,
        errorBorder: hasErrorMsg
            ? inputBorder.copyWith(
                borderSide: BorderSide(color: ColorManager.red))
            : inputBorder,
        hintText: hintText,
        hintStyle: TextStyleManager.s16w300.copyWith(color: ColorManager.black),
        errorStyle: TextStyleManager.s13w400.copyWith(color: ColorManager.red),
        filled: true,
        fillColor: fillColor,
        suffixIcon: Icon(
          IconsManager.expand,
          size: 32.sp,
        ),
        suffixIconColor: ColorManager.black,
      ),
      validator: hasErrorMsg
          ? (value) {
              if (value == null || value.isEmpty) {
                return errorMsg;
              } else {
                return null;
              }
            }
          : null,
    );
  }
}
