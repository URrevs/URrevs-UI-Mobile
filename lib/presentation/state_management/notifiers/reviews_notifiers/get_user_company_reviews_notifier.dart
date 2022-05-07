import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';

import '../../states/reviews_states/get_user_company_reviews_state.dart';

class GetUserCompanyReviewsNotifier
    extends StateNotifier<GetUserCompanyReviewsState> {
  GetUserCompanyReviewsNotifier({required String? userId})
      : _userId = userId,
        super(GetUserCompanyReviewsInitialState());

  int _round = 1;

  String? _userId;

  void getUserCompanyReviews() async {
    // get current items in the state
    List<CompanyReview> currentCompanyReviews = [];
    final currentState = state;
    if (currentState is GetUserCompanyReviewsLoadedState) {
      currentCompanyReviews = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetUserCompanyReviewsLoadingState();
    late Either<Failure, List<CompanyReview>> response;
    if (_userId == null) {
      response = await GetIt.I<Repository>().getMyCompanyReviews(_round);
    } else {
      response = await GetIt.I<Repository>()
          .getCompanyReviewsOfAnotherUser(_userId!, _round);
    }

    response.fold(
      // deal with failure
      (failure) => state = GetUserCompanyReviewsErrorState(failure: failure),
      (companyReviews) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = companyReviews.isEmpty;
        List<CompanyReview> newCompanyReviews = [
          ...currentCompanyReviews,
          ...companyReviews
        ];
        state = GetUserCompanyReviewsLoadedState(
          infiniteScrollingItems: newCompanyReviews,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
      },
    );
  }
}
