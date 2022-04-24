import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/elevated_buttton_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.text,
    required this.imagePath,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  /// Text to be shown on the button.
  final String text;

  /// Logo image path to be shown on the button.
  final String imagePath;

  /// Color of the button, includes text color and border color.
  final Color color;

  /// Callback function executed on pressing on the button.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButtonStyleManager.authButton.copyWith(
                shadowColor: MaterialStateProperty.all<Color>(color),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.r),
                    side: BorderSide(
                      color: color,
                      width: 1.5,
                    ),
                  ),
                )),
            child: SizedBox(
              height: 48.sp,
              width: 280.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: SvgPicture.asset(
                      imagePath,
                      width: 40.sp,
                      height: 40.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    text,
                    style: TextStyleManager.s18w700.copyWith(color: color),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
