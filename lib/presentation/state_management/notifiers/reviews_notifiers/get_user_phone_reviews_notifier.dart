import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';

import '../../states/reviews_states/get_user_phone_reviews_state.dart';

class GetUserPhoneReviewsNotifier
    extends StateNotifier<GetUserPhoneReviewsState> {
  GetUserPhoneReviewsNotifier({required String? userId})
      : _userId = userId,
        super(GetUserPhoneReviewsInitialState());

  int _round = 1;

  String? _userId;

  void getUserPhoneReviews() async {
    // get current items in the state
    List<PhoneReview> currentphoneReviews = [];
    final currentState = state;
    if (currentState is GetUserPhoneReviewsLoadedState) {
      currentphoneReviews = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetUserPhoneReviewsLoadingState();
    late Either<Failure, List<PhoneReview>> response;
    if (_userId == null) {
      response = await GetIt.I<Repository>().getMyPhoneReviews(_round);
    } else {
      response = await GetIt.I<Repository>()
          .getPhoneReviewsOfAnotherUser(_userId!, _round);
    }
    response.fold(
      // deal with failure
      (failure) => state = GetUserPhoneReviewsErrorState(failure: failure),
      (phoneReviews) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = phoneReviews.isEmpty;
        List<PhoneReview> newphoneReviews = [
          ...currentphoneReviews,
          ...phoneReviews
        ];
        state = GetUserPhoneReviewsLoadedState(
          infiniteScrollingItems: newphoneReviews,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
      },
    );
  }
}
