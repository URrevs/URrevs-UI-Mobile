import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Prompt that shows a dialog to encourage user to write more details in the review, it is shown when the user taps on the stars counter.
class ReviewEncouragementDialog extends StatelessWidget {
  const ReviewEncouragementDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
        title: '',
        hasTitle: false,
        content: SizedBox(
          width: 190.w,
          height: 55.h,
            child: Text(
          LocaleKeys.reviewEncouragement.tr(),
          style: TextStyleManager.s16w500,
          textAlign: TextAlign.center,
        )));
  }
}
