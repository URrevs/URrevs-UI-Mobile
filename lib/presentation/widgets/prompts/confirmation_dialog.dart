import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: title,
      hasTitle: true,
      content: Text(
        content,
        style: TextStyleManager.s16w500,
      ),
      actions: [
        TextButton(
          child: Text(
            LocaleKeys.no.tr(),
            style: TextStyleManager.s16w900.copyWith(
              color: ColorManager.black,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text(
            LocaleKeys.yes.tr(),
            style: TextStyleManager.s16w900.copyWith(
              color: ColorManager.red,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
