import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/reply.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_footer.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class CommentTree extends ConsumerStatefulWidget {
  CommentTree.fromComment(
    Comment comment, {
    Key? key,
    required this.onPressingReply,
    required this.parentPostType,
    required this.postUserId,
  })  : imageUrl = comment.photo,
        authorName = comment.userName,
        userId = comment.userId,
        commentText = comment.content,
        likeCount = comment.likes,
        datePosted = comment.createdAt,
        replies = comment.replies,
        liked = comment.liked,
        commentId = comment.id,
        _directInteractionProviderParams = DirectInteractionProviderParams(
          interactionId: comment.id,
          interactionType: InteractionType.comment,
          interaction: comment,
        ),
        super(key: key);

  final String? imageUrl;
  final String authorName;
  final String userId;
  final String commentText;
  final int likeCount;
  final DateTime datePosted;
  final bool liked;
  final List<ReplyModel> replies;
  final String commentId;
  final VoidCallback onPressingReply;
  final PostType parentPostType;
  final String postUserId;

  late final DirectInteractionProviderParams _directInteractionProviderParams;

  static CommentTree get dummyInstance => CommentTree.fromComment(
        Comment.dummyInstance,
        onPressingReply: () {},
        parentPostType: PostType.phoneReview,
        postUserId: 'dummy',
      );

  @override
  ConsumerState<CommentTree> createState() => _CommentTreeState();
}

class _CommentTreeState extends ConsumerState<CommentTree> {
  bool _expandReplies = false;

  void _onPressingShowReplies() {
    setState(() {
      _expandReplies = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final comment = ref.watch(
            directInteractionsProvider(widget._directInteractionProviderParams))
        as Comment;
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
                InteractionBody(
                  authorName: widget.authorName,
                  replyText: widget.commentText,
                  likeCount: comment.likes,
                  maxWidth: constraints.maxWidth - 16.w,
                  inQuestionCard: false,
                ),
                InteractionFooter(
                  onPressingReply: () {
                    setState(() => _expandReplies = true);
                    widget.onPressingReply();
                  },
                  datePosted: widget.datePosted,
                  maxWidth: constraints.maxWidth - 16.w,
                  liked: widget.liked,
                  interactionId: widget.commentId,
                  interactionType: InteractionType.comment,
                  parentPostType: widget.parentPostType,
                  replyParentId: null,
                  userId: widget.userId,
                  accepted: null,
                  getInteractionsProviderParams: null,
                  questionId: null,
                  postUserId: widget.postUserId,
                ),
                if (!_expandReplies && widget.replies.isNotEmpty) ...[
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
                    Reply.fromReplyModel(
                      widget.replies[i],
                      onPressingReply: widget.onPressingReply,
                      parentPostType: widget.parentPostType,
                      replyParentId: widget.commentId,
                      postUserId: widget.postUserId,
                    ),
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
