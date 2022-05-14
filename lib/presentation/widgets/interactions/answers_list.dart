import 'package:flutter/material.dart';

import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answer_tree.dart';

class AnswersList extends StatelessWidget {
  const AnswersList({
    Key? key,
    required this.answers,
    required this.parentPostType,
    required this.onPressingReplyList,
  }) : super(key: key);

  final List<Answer> answers;
  final PostType parentPostType;
  final List<VoidCallback> onPressingReplyList;

  static AnswersList get dummyInstance => AnswersList(
        answers: [],
        onPressingReplyList: [],
        parentPostType: PostType.phoneQuestion,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < answers.length; i++) ...[
          AnswerTree.fromAnswer(
            answers[i],
            parentPostType: parentPostType,
            inQuestionCard: false,
            onTappingAnswerInCard: null,
            onPressingReply: onPressingReplyList[i],
          ),
          if (i != answers.length - 1) VerticalSpacesBetween.interactionTrees,
        ],
        VerticalSpacesBetween.interactionsListAndMoreCommentsButton,
      ],
    );
  }
}
