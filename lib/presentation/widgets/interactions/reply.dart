import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_footer.dart';

class Reply extends ConsumerWidget {
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
  final String postUserId;
  final GetInteractionsProviderParams getInteractionsProviderParams;

  Reply.fromReplyModel(
    ReplyModel reply, {
    required this.onPressingReply,
    required this.parentPostType,
    required this.replyParentId,
    required this.postUserId,
    required this.getInteractionsProviderParams,
    Key? key,
  })  : imageUrl = reply.photo,
        authorName = reply.userName,
        replyText = reply.content,
        likeCount = reply.likes,
        datePosted = reply.createdAt,
        liked = reply.liked,
        interactionId = reply.id,
        userId = reply.userId,
        _replyProviderParams = ReplyProviderParams(
          replyId: reply.id,
          reply: reply,
        ),
        super(key: key);

  static Reply get dummyInstance => Reply.fromReplyModel(
        ReplyModel.dummyInstance,
        onPressingReply: () {},
        parentPostType: PostType.phoneReview,
        replyParentId: 'dummy',
        postUserId: 'dummy',
        getInteractionsProviderParams: GetInteractionsProviderParams(
            postId: 'dummy', postType: PostType.phoneReview),
      );

  late final ReplyProviderParams _replyProviderParams;

  @override
  Widget build(BuildContext context, ref) {
    final reply = ref.watch(replyProvider(_replyProviderParams));
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
                  likeCount: reply.likes,
                  maxWidth: constraints.maxWidth - 16.w,
                  inQuestionCard: false,
                  interactionType: InteractionType.reply,
                ),
                InteractionFooter(
                  onPressingReply: onPressingReply,
                  datePosted: datePosted,
                  maxWidth: constraints.maxWidth - 16.w,
                  liked: liked,
                  interactionId: interactionId,
                  interactionType: InteractionType.reply,
                  parentPostType: parentPostType,
                  replyParentId: replyParentId,
                  userId: userId,
                  accepted: null,
                  getInteractionsProviderParams: getInteractionsProviderParams,
                  questionId: null,
                  postUserId: postUserId,
                ),
              ],
            );
          }),
        )
      ],
    );
  }
}
