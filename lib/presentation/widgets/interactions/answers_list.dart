import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answer_tree.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AnswersList extends StatelessWidget {
  const AnswersList({Key? key, required this.answers}) : super(key: key);

  final List<AnswerTree> answers;

  static AnswersList get dummyInstance =>
      AnswersList(answers: DummyDataManager.answers);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < answers.length; i++) ...[
          answers[i],
          if (i != answers.length - 1) VerticalSpacesBetween.commentTrees,
        ],
        VerticalSpacesBetween.commentsListAndMoreCommentsButton,
        TextButton(
          onPressed: () {},
          style: TextButtonStyleManager.showMoreAnswers,
          child: Text(
            LocaleKeys.moreAnswers.tr(),
            style: TextStyleManager.s16w800.copyWith(color: ColorManager.black),
          ),
        ),
      ],
    );
  }
}
