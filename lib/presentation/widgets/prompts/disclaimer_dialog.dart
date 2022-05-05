
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class DisclaimerDialog extends StatelessWidget {
  const DisclaimerDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: '',
      hasTitle: false,
      content: SizedBox(
        width: 120.w,
        height: 35.h,
        child: Text(
          LocaleKeys.disclaimer.tr(),
          style: TextStyleManager.s16w500,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
