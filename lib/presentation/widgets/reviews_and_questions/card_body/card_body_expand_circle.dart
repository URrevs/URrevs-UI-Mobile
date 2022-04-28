import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';

/// The cyan circle with the arrow at the middle of the review card indicating
/// that the card is expandable.
class CardBodyExpandCircle extends StatelessWidget {
  const CardBodyExpandCircle({
    Key? key,
    required this.expanded,
  }) : super(key: key);

  /// Whether the card is expanded or not.
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppElevations.ev1_5,
      color: ColorManager.cyan,
      shape: CircleBorder(),
      child: Center(
        child: Icon(
          expanded ? IconsManager.collapse : IconsManager.expand,
          size: 28.sp,
          color: ColorManager.white,
        ),
      ),
    );
  }
}
