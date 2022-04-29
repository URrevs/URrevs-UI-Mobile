
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class GradButton extends StatelessWidget {
  const GradButton({
    required this.text,
    required this.icon,
    required this.width,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  /// The text to display in the button.
  final String text;

  /// The icon to display in the button.
  final Icon icon;

  /// The width of the button.
  final double width;

  /// The callback to execute when the button is tapped.
  final VoidCallback onPressed;
  
  @override
  Widget build(BuildContext context) {
    return GradientButton(
      callback: onPressed,
      increaseWidthBy: width,
      shadowColor: ColorManager.black.withOpacity(0.5),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 5),
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Text(
                text,
                style: TextStyleManager.s18w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
