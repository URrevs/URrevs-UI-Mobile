import 'dart:math';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/styles_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/comment_tree.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < Random().nextInt(3) + 1; i++) ...[
          CommentTree.dummyInstance
        ],
        TextButton(
          onPressed: () {},
          child: Text(
            LocaleKeys.moreComments.tr(),
            style: TextStyleManager.s16w800.copyWith(color: ColorManager.black),
          ),
        ),
      ],
    );
  }
}
