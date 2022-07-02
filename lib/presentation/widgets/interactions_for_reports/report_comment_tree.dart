import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_interaction_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_interaction_footer.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_reply.dart';

class ReportCommentTree extends StatefulWidget {
  ReportCommentTree.fromComment(
    Comment comment, {
    Key? key,
  })  : imageUrl = comment.photo,
        authorName = comment.userName,
        userId = comment.userId,
        commentText = comment.content,
        likeCount = comment.likes,
        datePosted = comment.createdAt,
        replies = comment.replies,
        super(key: key);

  final String? imageUrl;
  final String authorName;
  final String userId;
  final String commentText;
  final int likeCount;
  final DateTime datePosted;
  final List<ReplyModel> replies;

  @override
  State<ReportCommentTree> createState() => _CommentTreeState();
}

class _CommentTreeState extends State<ReportCommentTree> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(
          imageUrl: widget.imageUrl,
          radius: AppRadius.commentTreeAvatarRadius,
          onTap: () {
            Navigator.of(context).pushNamed(
              UserProfileScreen.routeName,
              arguments: UserProfileScreenArgs(userId: widget.userId),
            );
          },
        ),
        6.horizontalSpace,
        Expanded(
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReportInteractionBody(
                  authorName: widget.authorName,
                  replyText: widget.commentText,
                  likeCount: widget.likeCount,
                  maxWidth: constraints.maxWidth - 16.w,
                  inQuestionCard: false,
                  interactionType: InteractionType.comment,
                  authorId: widget.userId,
                ),
                ReportInteractionFooter(
                  datePosted: widget.datePosted,
                ),
                VerticalSpacesBetween.interactionBodyAndReplies,
                for (int i = 0; i < widget.replies.length; i++) ...[
                  ReportReply.fromReplyModel(
                    widget.replies[i],
                    key: ValueKey(widget.replies[i].id),
                  ),
                  if (i != widget.replies.length - 1)
                    VerticalSpacesBetween.replies,
                ],
              ],
            );
          }),
        )
      ],
    );
  }
}
