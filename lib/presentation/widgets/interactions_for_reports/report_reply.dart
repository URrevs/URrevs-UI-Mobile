import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_interaction_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_interaction_footer.dart';

class ReportReply extends ConsumerWidget {
  final String? imageUrl;
  final String authorName;
  final String replyText;
  final int likeCount;
  final DateTime datePosted;
  final String userId;

  ReportReply.fromReplyModel(
    ReplyModel reply, {
    Key? key,
  })  : imageUrl = reply.photo,
        authorName = reply.userName,
        replyText = reply.content,
        likeCount = reply.likes,
        datePosted = reply.createdAt,
        userId = reply.userId,
        super(key: key);

  @override
  Widget build(BuildContext context, ref) {
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
                ReportInteractionBody(
                  authorName: authorName,
                  replyText: replyText,
                  likeCount: likeCount,
                  maxWidth: constraints.maxWidth - 16.w,
                  inQuestionCard: false,
                  interactionType: InteractionType.reply,
                  authorId: userId,
                ),
                ReportInteractionFooter(
                  datePosted: datePosted,
                ),
              ],
            );
          }),
        )
      ],
    );
  }
}
