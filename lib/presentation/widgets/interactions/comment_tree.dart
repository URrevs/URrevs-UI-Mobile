import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/reply.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_footer.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class CommentTree extends StatefulWidget {
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
        key: UniqueKey(),
        imageUrl: DummyDataManager.imageUrl,
        authorName: DummyDataManager.authorName,
        commentText: DummyDataManager.sentenceOrMore,
        likeCount: DummyDataManager.randomInt,
        datePosted: DummyDataManager.postedDate,
        liked: DummyDataManager.randomBool,
        replies: DummyDataManager.replies,
      );

  @override
  State<CommentTree> createState() => _CommentTreeState();
}

class _CommentTreeState extends State<CommentTree> {
  bool _expandReplies = false;

  void _onPressingShowReplies() {
    setState(() {
      _expandReplies = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(
            imageUrl: widget.imageUrl,
            radius: AppRadius.commentTreeAvatarRadius),
        6.horizontalSpace,
        Expanded(
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InteractionBody(
                  authorName: widget.authorName,
                  replyText: widget.commentText,
                  likeCount: widget.likeCount,
                  maxWidth: constraints.maxWidth - 16.w,
                  inQuestionCard: false,
                ),
                InteractionFooter(
                  datePosted: widget.datePosted,
                  maxWidth: constraints.maxWidth - 16.w,
                  liked: widget.liked,
                  firstButtonType: InteractionFooterFirstButtonText.like,
                ),
                if (!_expandReplies) ...[
                  VerticalSpacesBetween.interactionBodyAndShowRepliesButton,
                  TextButton(
                    onPressed: _onPressingShowReplies,
                    style: TextButtonStyleManager.showReplies,
                    child: Text(
                        '${widget.replies.length} ${LocaleKeys.reply.tr()}'),
                  ),
                ],
                if (_expandReplies) ...[
                  VerticalSpacesBetween.interactionBodyAndReplies,
                  for (int i = 0; i < widget.replies.length; i++) ...[
                    widget.replies[i],
                    if (i != widget.replies.length - 1)
                      VerticalSpacesBetween.replies,
                  ],
                ],
              ],
            );
          }),
        )
      ],
    );
  }
}
