import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/requests/reviews_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';

import '../../states/reviews_states/add_comment_state.dart';

class AddCommentNotifier extends StateNotifier<AddCommentState> {
  AddCommentNotifier() : super(AddCommentInitialState());

  void addCommentToPhoneReview(
      String reviewId, AddCommentToPhoneReviewRequest request) async {
    state = AddCommentLoadingState();
    final response =
        await GetIt.I<Repository>().addCommentToPhoneReview(reviewId, request);
    response.fold(
      (failure) => state = AddCommentErrorState(failure: failure),
      (commentId) {
        state = AddCommentLoadedState(commentId: commentId);
      },
    );
  }

  void addCommentToCompanyReview(
      String reviewId, AddCommentToCompanyReviewRequest request) async {
    state = AddCommentLoadingState();
    final response = await GetIt.I<Repository>()
        .addCommentToCompanyReview(reviewId, request);
    response.fold(
      (failure) => state = AddCommentErrorState(failure: failure),
      (commentId) {
        state = AddCommentLoadedState(commentId: commentId);
      },
    );
  }
}
