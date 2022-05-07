import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';

import '../../states/reviews_states/get_company_review_state.dart';

class GetCompanyReviewNotifier extends StateNotifier<GetCompanyReviewState> {
  GetCompanyReviewNotifier() : super(GetCompanyReviewInitialState());

  void getCompanyReview(String reviewId) async {
    state = GetCompanyReviewLoadingState();
    final response = await GetIt.I<Repository>().getCompanyReview(reviewId);
    response.fold(
      (failure) => state = GetCompanyReviewErrorState(failure: failure),
      (review) {
        state = GetCompanyReviewLoadedState(review: review);
      },
    );
  }
}
