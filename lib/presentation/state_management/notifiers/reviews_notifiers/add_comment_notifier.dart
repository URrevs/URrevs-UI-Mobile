import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'package:urrevs_ui_mobile/data/requests/base_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/reviews_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';

import '../../states/reviews_states/add_comment_state.dart';

class AddCommentNotifier extends StateNotifier<AddCommentState> {
  AddCommentNotifier({
    required this.postId,
    required this.postType,
  }) : super(AddCommentInitialState());

  final String postId;
  final PostType postType;

  void addComment(AddInteractionRequest request) async {
    state = AddCommentLoadingState();
    late Either<Failure, String> response;
    if (postType == PostType.phoneReview) {
      response =
          await GetIt.I<Repository>().addCommentToPhoneReview(postId, request);
    } else {
      response = await GetIt.I<Repository>()
          .addCommentToCompanyReview(postId, request);
    }
    response.fold(
      (failure) => state = AddCommentErrorState(failure: failure),
      (commentId) {
        state = AddCommentLoadedState(commentId: commentId);
      },
    );
  }

  void addReply(String commentId, AddInteractionRequest request) async {
    state = AddCommentLoadingState();
    Either<Failure, String> response;
    if (postType == PostType.phoneReview) {
      response = await GetIt.I<Repository>()
          .addReplyToPhoneReviewComment(commentId, request);
    } else {
      response = await GetIt.I<Repository>()
          .addReplyToCompanyReviewComment(commentId, request);
    }
    response.fold(
      (failure) => state = AddCommentErrorState(failure: failure),
      (replyId) {
        state = AddCommentLoadedState(commentId: replyId);
      },
    );
  }
}
