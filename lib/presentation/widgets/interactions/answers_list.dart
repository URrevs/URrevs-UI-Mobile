import 'package:flutter/material.dart';

import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answer_tree.dart';

class AnswersList extends StatelessWidget {
  const AnswersList({
    Key? key,
    required this.answers,
    required this.parentPostType,
    required this.questionId,
    required this.onPressingReplyList,
    required this.getInteractionsProviderParams,
    required this.postUserId,
    this.expandFirstAnswerReplies = false,
  }) : super(key: key);

  final List<Answer> answers;
  final PostType parentPostType;
  final List<VoidCallback> onPressingReplyList;
  final GetInteractionsProviderParams getInteractionsProviderParams;
  final bool expandFirstAnswerReplies;
  final String questionId;
  final String postUserId;

  static AnswersList get dummyInstance => AnswersList(
        answers: [],
        questionId: 'question id',
        postUserId: 'post user id',
        onPressingReplyList: [],
        parentPostType: PostType.phoneQuestion,
        getInteractionsProviderParams: GetInteractionsProviderParams(
          postId: '',
          postType: PostType.phoneQuestion,
        ),
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
            expandReplies: i == 0 && expandFirstAnswerReplies,
            getInteractionsProviderParams: getInteractionsProviderParams,
            questionId: questionId,
            postUserId: postUserId,
            key: ValueKey('${answers[i].id} ${answers[i].accepted}'),
          ),
          if (i != answers.length - 1) VerticalSpacesBetween.interactionTrees,
        ],
        VerticalSpacesBetween.interactionsListAndMoreCommentsButton,
      ],
    );
  }
}
