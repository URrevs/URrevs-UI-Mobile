import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key, required this.failure}) : super(key: key);

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.dialogRadius),
      ),
      title: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 14.h),
            child: Text(LocaleKeys.somethingWentWrong.tr()),
          ),
          Positioned(
            top: 0,
            left: context.isArabic ? 0 : null,
            right: context.isArabic ? null : 0,
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorManager.dialogCloseIconBackgroundGrey,
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withOpacity(0.2),
                          blurRadius: 1.sp,
                          spreadRadius: 1.sp,
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: Padding(
                    padding: EdgeInsets.all(2.sp),
                    child: Icon(
                      FontAwesomeIcons.xmark,
                      size: 24.sp,
                      color: ColorManager.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      titlePadding: EdgeInsets.zero,
      titleTextStyle: TextStyleManager.s16w700.copyWith(
        color: ColorManager.black,
        fontFamily: FontConstants.tajawal,
      ),
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
        child: Text(failure.message),
      ),
      contentPadding: EdgeInsets.zero,
      contentTextStyle: TextStyleManager.s16w500.copyWith(
        color: ColorManager.black,
        fontFamily: FontConstants.tajawal,
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(
            LocaleKeys.ok.tr(),
            style: TextStyleManager.s16w800.copyWith(
              color: ColorManager.blue,
            ),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
    );
  }
}
