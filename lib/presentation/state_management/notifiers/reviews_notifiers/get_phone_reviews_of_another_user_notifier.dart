import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';

import '../../states/reviews_states/get_phone_reviews_of_another_user_state.dart';

class GetPhoneReviewsOfAnotherUserNotifier
    extends StateNotifier<GetPhoneReviewsOfAnotherUserState> {
  GetPhoneReviewsOfAnotherUserNotifier()
      : super(GetPhoneReviewsOfAnotherUserInitialState());

  int _round = 1;

  void getPhoneReviewsOfAnotherUser(String userId) async {
    // get current items in the state
    List<PhoneReview> currentPhoneReviews = [];
    final currentState = state;
    if (currentState is GetPhoneReviewsOfAnotherUserLoadedState) {
      currentPhoneReviews = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetPhoneReviewsOfAnotherUserLoadingState();
    final response = await GetIt.I<Repository>()
        .getPhoneReviewsOfAnotherUser(userId, _round);
    response.fold(
      // deal with failure
      (failure) =>
          state = GetPhoneReviewsOfAnotherUserErrorState(failure: failure),
      (phoneReviews) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = phoneReviews.isEmpty;
        List<PhoneReview> newPhoneReviews = [
          ...currentPhoneReviews,
          ...phoneReviews,
        ];
        state = GetPhoneReviewsOfAnotherUserLoadedState(
          infiniteScrollingItems: newPhoneReviews,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
      },
    );
  }
}
