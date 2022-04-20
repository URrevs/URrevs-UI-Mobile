import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';

/// Build the leading part of the header.
/// Contains the profile photo of the user.
class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.imageUrl,
    required this.radius,
  }) : super(key: key);

  /// Profile image url of the current logged in user.
  final String imageUrl;

  /// Radius of the displayed [CircleAvatar].
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: ColorManager.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.network(imageUrl),
      ),
    );
  }
}