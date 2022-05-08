import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';

import '../../states/reviews_states/get_reviews_on_certain_phone_state.dart';

class GetReviewsOnCertainPhoneNotifier
    extends StateNotifier<GetReviewsOnCertainPhoneState> {
  GetReviewsOnCertainPhoneNotifier({required String phoneId})
      : _phoneId = phoneId,
        super(GetReviewsOnCertainPhoneInitialState());

  int _round = 1;

  String _phoneId;

  void getReviewsOnCertainPhone() async {
    // get current items in the state
    List<PhoneReview> currentphoneReviews = [];
    final currentState = state;
    if (currentState is GetReviewsOnCertainPhoneLoadedState) {
      currentphoneReviews = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetReviewsOnCertainPhoneLoadingState();
    final response =
        await GetIt.I<Repository>().getReviewsOnCertainPhone(_phoneId, _round);
    response.fold(
      // deal with failure
      (failure) => state = GetReviewsOnCertainPhoneErrorState(failure: failure),
      (phoneReviews) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = phoneReviews.isEmpty;
        List<PhoneReview> newphoneReviews = [
          ...currentphoneReviews,
          ...phoneReviews
        ];
        state = GetReviewsOnCertainPhoneLoadedState(
          infiniteScrollingItems: newphoneReviews,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
      },
    );
  }
}
