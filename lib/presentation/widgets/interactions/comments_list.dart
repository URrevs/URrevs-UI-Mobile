import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';

import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_widgets/empty_list_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comment_tree.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({
    Key? key,
    required this.comments,
    required this.onPressingReplyList,
    required this.parentPostType,
    required this.postUserId,
    required this.getInteractionsProviderParams,
  }) : super(key: key);

  final List<Comment> comments;
  final List<VoidCallback> onPressingReplyList;
  final PostType parentPostType;
  final String postUserId;
  final GetInteractionsProviderParams getInteractionsProviderParams;

  static CommentsList get dummyInstance => CommentsList(
        comments: [],
        onPressingReplyList: [],
        parentPostType: PostType.phoneReview,
        postUserId: 'post user id',
        getInteractionsProviderParams: GetInteractionsProviderParams(
            postId: 'dummy', postType: PostType.phoneReview),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < comments.length; i++) ...[
          CommentTree.fromComment(
            comments[i],
            key: ValueKey(comments[i].id),
            onPressingReply: onPressingReplyList[i],
            parentPostType: parentPostType,
            postUserId: postUserId,
            getInteractionsProviderParams: getInteractionsProviderParams,
          ),
          if (i != comments.length - 1) VerticalSpacesBetween.interactionTrees,
        ],
        VerticalSpacesBetween.interactionsListAndMoreCommentsButton,
      ],
    );
  }
}
