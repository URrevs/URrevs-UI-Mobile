import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/requests/reviews_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';

import '../../states/reviews_states/add_review_reply_state.dart';

class AddReviewReplyNotifier extends StateNotifier<AddReviewReplyState> {
  AddReviewReplyNotifier() : super(AddReviewReplyInitialState());

  void addReplyToPhoneReviewComment(
      String commentId, AddReplyToPhoneReviewCommentRequest request) async {
    state = AddReviewReplyLoadingState();
    final response = await GetIt.I<Repository>()
        .addReplyToPhoneReviewComment(commentId, request);
    response.fold(
      (failure) => state = AddReviewReplyErrorState(failure: failure),
      (replyId) {
        state = AddReviewReplyLoadedState(replyId: replyId);
      },
    );
  }

  void addReplyToCompanyReviewComment(
      String commentId, AddReplyToCompanyReviewCommentRequest request) async {
    state = AddReviewReplyLoadingState();
    final response = await GetIt.I<Repository>()
        .addReplyToCompanyReviewComment(commentId, request);
    response.fold(
      (failure) => state = AddReviewReplyErrorState(failure: failure),
      (replyId) {
        state = AddReviewReplyLoadedState(replyId: replyId);
      },
    );
  }
}
