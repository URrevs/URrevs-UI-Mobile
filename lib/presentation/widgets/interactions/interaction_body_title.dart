import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';

class InteractionBodyTitle extends StatelessWidget {
  const InteractionBodyTitle({
    Key? key,
    required this.authorName,
    required this.authorId
  }) : super(key: key);

  final String authorName;
  final String authorId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          UserProfileScreen.routeName,
          arguments: UserProfileScreenArgs(userId: authorId),
        );
      },
      child: Text(
        authorName,
        style: TextStyleManager.s15w700,
      ),
    );
  }
}
