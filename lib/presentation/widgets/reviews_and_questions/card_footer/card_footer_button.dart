import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

/// Button used in CardFooterButtonBar
class CardFooterButton extends StatelessWidget {
  const CardFooterButton({
    Key? key,
    this.liked,
    required this.iconData,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  /// Is the review liked by the current logged in user or not.
  final bool? liked;

  /// Icon to be shown by the button.
  final IconData iconData;

  /// Text to be shown on the button.
  final String text;

  /// Callback function executed on pressing on the button.
  final VoidCallback onPressed;

  /// Returns a [SizedBox] with the fixed size 100x40.
  ///
  /// Used to wrap like, comment and share [TextButton]s to give them a fixed
  /// size and to resize them using the [ScreenUtil] sizes.
  SizedBox _sizedBox_100x40({required Widget child}) {
    return SizedBox(
      width: 100.w,
      height: 40.h,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(iconData, size: 23.sp),
      label: Text(text),
      style: TextButton.styleFrom(
        
        maximumSize: Size(double.infinity, double.infinity),
        primary:
            (liked != null && liked!) ? ColorManager.blue : ColorManager.grey,
          textStyle: TextStyleManager.s16w700.copyWith(
            fontFamily: FontConstants.tajawal,
          ),
          padding: EdgeInsets.all(0)
      ),
    );
  }
}
