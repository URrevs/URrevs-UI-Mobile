import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';
import 'dart:math' as math;

class TxtButton extends StatelessWidget {
  const TxtButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.reverseIcon,
      required this.onPressed})
      : super(key: key);

  /// The text to display in the button.
  final Text text;

  /// The icon to display in the button.
  final Widget icon;

  /// The callback to execute when the button is tapped.
  final VoidCallback onPressed;

  /// Flag to reverse the icon, used in RTL buttons.
  final bool reverseIcon;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        decoration: ShapeDecoration(
          color: ColorManager.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: TextButton(
              onPressed: onPressed,
              child: Row(
                children: [
                  context.isArabic && reverseIcon
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: icon)
                      : icon,
                  SizedBox(width: 5.w),
                  text,
                ],
              )),
        ),
      ),
    );
  }
}
