import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/requests/reviews_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';

import '../../states/reviews_states/add_phone_review_state.dart';

class AddPhoneReviewNotifier extends StateNotifier<AddPhoneReviewState> {
  AddPhoneReviewNotifier() : super(AddPhoneReviewInitialState());

  void addPhoneReview(AddPhoneReviewRequest request) async {
    state = AddPhoneReviewLoadingState();
    final response = await GetIt.I<Repository>().addPhoneReview(request);
    response.fold(
      (failure) => state = AddPhoneReviewErrorState(failure: failure),
      (phoneReview) {
        state = AddPhoneReviewLoadedState(phoneReview: phoneReview);
      },
    );
  }
}
