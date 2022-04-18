import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Returns a row containing a text and an icon.
/// This row is fixed at ltr whatever the locale is (arabic or english).
/// This makes the numbers always on the left side of the icons (which looks
/// better).
class CardFooterInteractionItem extends StatelessWidget {
  const CardFooterInteractionItem({
    Key? key,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Text(text),
        2.horizontalSpace,
        Icon(iconData),
      ],
    );
  }
}
