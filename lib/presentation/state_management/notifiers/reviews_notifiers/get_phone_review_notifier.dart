import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';

import '../../states/reviews_states/get_phone_review_state.dart';

class GetPhoneReviewNotifier extends StateNotifier<GetPhoneReviewState> {
  GetPhoneReviewNotifier() : super(GetPhoneReviewInitialState());

  void getPhoneReview(String reviewId) async {
    state = GetPhoneReviewLoadingState();
    final response = await GetIt.I<Repository>().getPhoneReview(reviewId);
    response.fold(
      (failure) => state = GetPhoneReviewErrorState(failure: failure),
      (review) {
        state = GetPhoneReviewLoadedState(review: review);
      },
    );
  }
}
