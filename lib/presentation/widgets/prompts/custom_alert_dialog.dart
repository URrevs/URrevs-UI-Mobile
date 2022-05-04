
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/alert_dialog_title.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    required this.title,
    required this.content,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.interactionBodyRadius),
      ),
      title: AlertDialogTitle(
        titleText: Text(
          title,
          style: TextStyleManager.s16w700.copyWith(
            color: ColorManager.black,
            fontFamily: FontConstants.tajawal,
          ),
        ),
      ),
      insetPadding: EdgeInsets.all(10.sp),
      content: content,
    );
  }
}
