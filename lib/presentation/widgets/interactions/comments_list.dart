import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/comment_tree.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({Key? key, required this.comments}) : super(key: key);

  final List<CommentTree> comments;

  static CommentsList get dummyInstance =>
      CommentsList(comments: DummyDataManager.comments);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < comments.length; i++) ...[
          comments[i],
          if (i != comments.length - 1) VerticalSpacesBetween.commentTrees,
        ],
        VerticalSpacesBetween.commentsListAndMoreCommentsButton,
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.all(0),
          ),
          child: Text(
            LocaleKeys.moreComments.tr(),
            style: TextStyleManager.s16w800.copyWith(color: ColorManager.black),
          ),
        ),
      ],
    );
  }
}
