import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/reply.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/reply_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/reply_footer.dart';

class CommentTree extends StatelessWidget {
  const CommentTree({
    Key? key,
    required this.imageUrl,
    required this.authorName,
    required this.commentText,
    required this.likeCount,
    required this.datePosted,
    required this.replies,
    required this.liked,
  }) : super(key: key);

  final String imageUrl;
  final String authorName;
  final String commentText;
  final int likeCount;
  final DateTime datePosted;
  final bool liked;
  final List<Reply> replies;

  static CommentTree get dummyInstance => CommentTree(
        imageUrl: DummyDataManager.imageUrl,
        authorName: DummyDataManager.authorName,
        commentText: DummyDataManager.sentenceOrMore,
        likeCount: DummyDataManager.randomInt,
        datePosted: DummyDataManager.postedDate,
        liked: DummyDataManager.randomBool,
        replies: DummyDataManager.replies,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(imageUrl: imageUrl, radius: AppRadius.commentTreeAvatarRadius),
        6.horizontalSpace,
        Expanded(
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReplyBody(
                  authorName: authorName,
                  replyText: commentText,
                  likeCount: likeCount,
                  maxWidth: constraints.maxWidth - 16.w,
                ),
                ReplyFooter(
                  datePosted: datePosted,
                  maxWidth: constraints.maxWidth - 16.w,
                  liked: liked,
                ),
                AppHeights.verticalSpaceBetweenReplies.verticalSpace,
                for (Reply reply in replies) ...[
                  reply,
                  AppHeights.verticalSpaceBetweenReplies.verticalSpace,
                ],
              ],
            );
          }),
        )
      ],
    );
  }
}
