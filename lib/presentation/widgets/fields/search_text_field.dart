
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.searchCtl,
    required this.fillColor,
  }) : super(key: key);

  final TextEditingController searchCtl;
  final Color fillColor;
  @override
  Widget build(BuildContext context) {
    final InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40.r),
      borderSide: BorderSide(width: 0.8, color: ColorManager.strokeGrey),
    );
    FocusNode focusNode = FocusNode();
    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: TextField(
        cursorColor: ColorManager.black,
        controller: searchCtl,
        focusNode: focusNode,
        style: TextStyleManager.s18w500.copyWith(
          color: ColorManager.black,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
           horizontal: 20.w
          ),
          suffixIcon: Icon(
            IconsManager.search,
            size: 29.sp,
          ),
          suffixIconColor: ColorManager.black,
          hintText: LocaleKeys.writeProductName.tr(),
          hintStyle: TextStyleManager.s16w300.copyWith(
            color: ColorManager.black,
          ),
          filled: true,
          fillColor: fillColor,
          focusColor: Colors.red,
          errorBorder: inputBorder,
          disabledBorder: inputBorder,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder.copyWith(borderSide: BorderSide(color: ColorManager.blue)),
        ),
        onChanged: (_) => print(_),
      ),
    );
  }
}
