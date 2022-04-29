import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'dart:math' as math;

class GradButton extends StatelessWidget {
  const GradButton({
    required this.text,
    required this.icon,
    required this.width,
    required this.reverseIcon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  /// The text to display in the button.
  final Text text;

  /// The icon to display in the button.
  final Icon icon;

  /// The width of the button.
  final double width;

  /// The callback to execute when the button is tapped.
  final VoidCallback onPressed;

  /// Flag to reverse the icon, used in RTL buttons.
  final bool reverseIcon;
  @override
  Widget build(BuildContext context) {
    return GradientButton(
      callback: onPressed,
      increaseWidthBy: width,
      shadowColor: ColorManager.black.withOpacity(0.5).withOpacity(0.5),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            context.isArabic && reverseIcon? Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: icon) : icon,
            SizedBox(width: 5),
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: text,
            ),
          ],
        ),
      ),
    );
  }
}
