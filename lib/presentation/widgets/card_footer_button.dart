import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';

/// Button used in CardFooterButtonBar
class CardFooterButton extends StatelessWidget {
  const CardFooterButton({
    Key? key,
    this.liked,
    required this.iconData,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final bool? liked;
  final IconData iconData;
  final String text;
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
    return _sizedBox_100x40(
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(iconData),
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(text),
        ),
        style: (liked != null && liked!)
            ? Theme.of(context).textButtonTheme.style!.copyWith(
                  foregroundColor: MaterialStateProperty.all(
                    ColorManager.blue,
                  ),
                )
            : null,
      ),
    );
  }
}
