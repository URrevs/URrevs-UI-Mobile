import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';

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

  String _imageWithHeight(String imageUrl) {
    if (imageUrl.contains('https://graph.facebook.com')) {
      return '$imageUrl?height=${(radius * 2).toInt()}';
    }
    return imageUrl;
  }

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
                ? Image.network(
                    _imageWithHeight(imageUrl!),
                    fit: BoxFit.cover,
                    errorBuilder: (context, _, __) {
                      return Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            (['🐷', '🐮', '🐶', '🐸']..shuffle()).first,
                            style: TextStyle(fontSize: 100),
                          ),
                        ),
                      );
                    },
                  )
                : Icon(
                    Icons.account_circle,
                    color: ColorManager.grey,
                    size: radius * 2,
                  ),
          ),
        ),
      ),
    );
  }
}
