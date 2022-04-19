import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';

/// Build the leading part of the header.
/// Contains the profile photo of the user.
class CardHeaderAvatar extends StatelessWidget {
  const CardHeaderAvatar({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  /// Profile image url of the current logged in user.
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30.sp,
      backgroundColor: ColorManager.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: Image.network(imageUrl),
      ),
    );
  }
}
