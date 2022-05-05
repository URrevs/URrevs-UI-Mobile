import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// a prompt that navigates to specs compare screen to compare between 2 products

class CompareDialoge extends StatefulWidget {
  const CompareDialoge({
    Key? key,
    required this.searchCtl,
    required this.productName1,
  }) : super(key: key);

  /// The controller for the search field.
  final TextEditingController searchCtl;

  /// The name of the first product.
  final String productName1;
  @override
  State<CompareDialoge> createState() => _CompareDialogeState();
}

class _CompareDialogeState extends State<CompareDialoge> {
  @override
  Widget build(BuildContext context) {
    final InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40.r),
      borderSide: BorderSide(width: 0.5, color: ColorManager.strokeGrey),
    );
    FocusNode focusNode = FocusNode();

    return CustomAlertDialog(
      title: '',
      hasTitle: true,
      content: Column(
        children: [
          Text(
            LocaleKeys.compare.tr() +
                ' ' +
                widget.productName1 +
                ' ' +
                LocaleKeys.withWord.tr(),
            style: TextStyleManager.s18w500,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
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
              controller: widget.searchCtl,
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
                filled: true,
                fillColor: ColorManager.textFieldGrey,
                focusColor: Colors.red,
                errorBorder: inputBorder,
                disabledBorder: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: inputBorder,
              ),
              onChanged: (_) => print(_),
            ),
          ),
          SizedBox(
            height: 70.h,
          ),
          GradButton(
              text: Text(
                LocaleKeys.compare.tr(),
                style: TextStyleManager.s18w700,
              ),
              icon: Icon(
                IconsManager.compare,
                size: 28.sp,
              ),
              width: 310.w,
              reverseIcon: false,
              onPressed: () {})
        ],
      ),
    );
  }
}
