import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'dart:math' as math;

class GradButton extends StatelessWidget {
  const GradButton({
    required this.text,
    required this.icon,
    required this.width,
    required this.reverseIcon,
    required this.onPressed,
    this.isEnabled = true,
    Key? key,
  }) : super(key: key);

  /// The text to display in the button.
  final Text text;

  /// The icon to display in the button.
  final Widget icon;

  /// The width of the button.
  final double width;

  /// The callback to execute when the button is tapped.
  final VoidCallback onPressed;

  final bool isEnabled;

  /// Flag to reverse the icon, used in RTL buttons.
  final bool reverseIcon;
  @override
  Widget build(BuildContext context) {
    return GradientButton(
      isEnabled: isEnabled,
      callback: onPressed,
      increaseWidthBy: width,
      increaseHeightBy: 0,
      shadowColor: ColorManager.black.withOpacity(0.5).withOpacity(0.5),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            context.isArabic && reverseIcon
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: icon)
                : icon,
            SizedBox(width: 5),
            text,
          ],
        ),
      ),
    );
  }
}
