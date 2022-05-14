import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'package:urrevs_ui_mobile/data/requests/base_requests.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

import '../../states/reviews_states/add_interaction_state.dart';

class AddInteractionNotifier extends StateNotifier<AddInteractionState> {
  AddInteractionNotifier({
    required this.postId,
    required this.postType,
  }) : super(AddInteractionInitialState());

  final String postId;
  final PostType postType;

  void addComment(AddInteractionRequest request) async {
    print(postType);
    state = AddInteractionLoadingState();
    late Either<Failure, String> response;
    switch (postType) {
      case PostType.phoneReview:
        response = await GetIt.I<Repository>()
            .addCommentToPhoneReview(postId, request);
        break;
      case PostType.companyReview:
        response = await GetIt.I<Repository>()
            .addCommentToCompanyReview(postId, request);
        break;
      case PostType.phoneQuestion:
        response = await GetIt.I<Repository>()
            .addAnswerToPhoneQuestion(postId, request);
        break;
      case PostType.companyQuestion:
        response = await GetIt.I<Repository>()
            .addAnswerToCompanyQuestion(postId, request);
        break;
    }
    response.fold(
      (failure) => state = AddInteractionErrorState(failure: failure),
      (interactionId) {
        state = AddInteractionLoadedState(interactionId: interactionId);
      },
    );
  }

  void addReply(String parentId, AddInteractionRequest request) async {
    state = AddInteractionLoadingState();
    Either<Failure, String> response;
    switch (postType) {
      case PostType.phoneReview:
        response = await GetIt.I<Repository>()
            .addReplyToPhoneReviewComment(parentId, request);
        break;
      case PostType.companyReview:
        response = await GetIt.I<Repository>()
            .addReplyToCompanyReviewComment(parentId, request);
        break;
      case PostType.phoneQuestion:
        response = await GetIt.I<Repository>()
            .addReplyToPhoneQuestionAnswer(parentId, request);
        break;
      case PostType.companyQuestion:
        response = await GetIt.I<Repository>()
            .addReplyToCompanyQuestionAnswer(parentId, request);
        break;
    }
    response.fold(
      (failure) => state = AddInteractionErrorState(failure: failure),
      (replyId) {
        state = AddInteractionLoadedState(interactionId: replyId);
      },
    );
  }
}
