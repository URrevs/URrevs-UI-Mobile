import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';

/// Build the leading part of the header.
/// Contains the profile photo of the user.
class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.imageUrl,
    required this.radius,
    this.onTap,
  }) : super(key: key);

  /// Profile image url of the current logged in user.
  final String? imageUrl;

  /// Radius of the displayed [CircleAvatar].
  final double radius;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: ColorManager.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: SizedBox(
            height: radius * 2,
            width: radius * 2,
            child: imageUrl != null
                ? Image.network(imageUrl!, fit: BoxFit.cover)
                : Image.network(
                    StringsManager.imagePlaceHolder,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
