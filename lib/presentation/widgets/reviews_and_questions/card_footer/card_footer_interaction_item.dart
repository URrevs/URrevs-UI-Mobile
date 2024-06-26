import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

/// Returns a row containing a text and an icon.
/// This row is fixed at ltr whatever the locale is (arabic or english).
/// This makes the numbers always on the left side of the icons (which looks
/// better).
class CardFooterInteractionItem extends StatelessWidget {
  const CardFooterInteractionItem({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  /// Text to be shown by the item (usually a number).
  final String text;

  /// Icon to be shown bu the item.
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Text(
          text,
          style: TextStyleManager.s14w400.copyWith(
            color: ColorManager.black,
          ),
        ),
        5.horizontalSpace,
        Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: icon,
        ),
      ],
    );
  }
}
