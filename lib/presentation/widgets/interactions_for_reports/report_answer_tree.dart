import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_interaction_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_interaction_footer.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_reply.dart';

class ReportAnswerTree extends StatefulWidget {
  ReportAnswerTree.fromAnswer(
    Answer answer, {
    Key? key,
  })  : userId = answer.userId,
        imageUrl = answer.photo,
        authorName = answer.userName,
        usedSinceDate = answer.ownedAt,
        answerText = answer.content,
        likeCount = answer.upvotes,
        datePosted = answer.createdAt,
        replies = answer.replies,
        super(key: key);

  final String userId;
  final String? imageUrl;
  final String authorName;
  final DateTime? usedSinceDate;
  final String answerText;
  final int likeCount;
  final DateTime datePosted;
  // final bool accepted;
  final List<ReplyModel> replies;

  @override
  State<ReportAnswerTree> createState() => _AnswerTreeState();
}

class _AnswerTreeState extends State<ReportAnswerTree> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (isAccepted) ...[
        //   FaIcon(
        //     IconsManager.acceptedAnswer,
        //     size: 30.sp,
        //     color: ColorManager.blue,
        //   ),
        //   12.horizontalSpace,
        // ],
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
                  replyText: widget.answerText,
                  likeCount: widget.likeCount,
                  maxWidth: constraints.maxWidth - 16.w,
                  usedSinceDate: widget.usedSinceDate,
                  inQuestionCard: false,
                  interactionType: InteractionType.answer,
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
