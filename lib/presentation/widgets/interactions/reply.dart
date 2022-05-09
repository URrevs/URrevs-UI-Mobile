import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_footer.dart';

class Reply extends StatelessWidget {
  final String? imageUrl;
  final String authorName;
  final String replyText;
  final int likeCount;
  final DateTime datePosted;
  final bool liked;
  final VoidCallback onPressingReply;
  final String interactionId;
  final String replyParentId;
  final PostType parentPostType;
  final String userId;

  const Reply({
    Key? key,
    required this.imageUrl,
    required this.authorName,
    required this.replyText,
    required this.likeCount,
    required this.datePosted,
    required this.liked,
    required this.onPressingReply,
    required this.interactionId,
    required this.parentPostType,
    required this.replyParentId,
    required this.userId,
  }) : super(key: key);

  static Reply get dummyInstance => Reply(
        imageUrl: DummyDataManager.imageUrl,
        authorName: DummyDataManager.authorName,
        replyText: DummyDataManager.reply,
        likeCount: DummyDataManager.randomInt,
        datePosted: DummyDataManager.postedDate,
        liked: DummyDataManager.randomBool,
        onPressingReply: () {},
        interactionId: DummyDataManager.randomInt.toString(),
        userId: DummyDataManager.randomInt.toString(),
        parentPostType: PostType.phoneReview,
        replyParentId: DummyDataManager.randomInt.toString(),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(
          imageUrl: imageUrl,
          radius: AppRadius.replyAvatarRadius,
          onTap: () {
            Navigator.of(context).pushNamed(
              UserProfileScreen.routeName,
              arguments: UserProfileScreenArgs(userId: userId),
            );
          },
        ),
        5.horizontalSpace,
        Expanded(
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InteractionBody(
                  authorName: authorName,
                  replyText: replyText,
                  likeCount: likeCount,
                  maxWidth: constraints.maxWidth - 16.w,
                  inQuestionCard: false,
                ),
                InteractionFooter(
                  onPressingReply: onPressingReply,
                  datePosted: datePosted,
                  maxWidth: constraints.maxWidth - 16.w,
                  liked: liked,
                  firstButtonType: InteractionFooterFirstButtonText.like,
                  interactionId: interactionId,
                  interactionType: InteractionType.reply,
                  parentPostType: parentPostType,
                  replyParentId: replyParentId,
                  userId: userId,
                ),
              ],
            );
          }),
        )
      ],
    );
  }
}
