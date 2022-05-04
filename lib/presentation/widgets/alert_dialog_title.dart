
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';

/// Alert dialog title with exiting button
class AlertDialogTitle extends StatelessWidget {
  const AlertDialogTitle({
    required this.titleText,
    Key? key,
  }) : super(key: key);
  /// The text to display in the title.
  final Text titleText;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        titleText,
        Positioned(
          top: -20.h,
          left: context.isArabic ? -10.w : null,
          right: context.isArabic ? null : -10.w,
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
    );
  }
}