import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';

import '../../states/reviews_states/get_company_reviews_of_another_user.dart';

class GetCompanyReviewsOfAnotherUserNotifier
    extends StateNotifier<GetCompanyReviewsOfAnotherUserState> {
  GetCompanyReviewsOfAnotherUserNotifier()
      : super(GetCompanyReviewsOfAnotherUserInitialState());

  int _round = 1;

  void getCompanyReviewsOfAnotherUser(String userId) async {
    // get current items in the state
    List<CompanyReview> currentCompanyReviews = [];
    final currentState = state;
    if (currentState is GetCompanyReviewsOfAnotherUserLoadedState) {
      currentCompanyReviews = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetCompanyReviewsOfAnotherUserLoadingState();
    final response = await GetIt.I<Repository>()
        .getCompanyReviewsOfAnotherUser(userId, _round);
    response.fold(
      // deal with failure
      (failure) =>
          state = GetCompanyReviewsOfAnotherUserErrorState(failure: failure),
      (companyReviews) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = companyReviews.isEmpty;
        List<CompanyReview> newCompanyReviews = [
          ...currentCompanyReviews,
          ...companyReviews
        ];
        state = GetCompanyReviewsOfAnotherUserLoadedState(
          infiniteScrollingItems: newCompanyReviews,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
      },
    );
  }
}
