// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get_it/get_it.dart';
// import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
// import 'package:urrevs_ui_mobile/domain/repository.dart';

// import '../../states/reviews_states/get_my_companies_reviews_state.dart';

// class GetMyCompanyReviewsNotifier
//     extends StateNotifier<GetMyCompanyReviewsState> {
//   GetMyCompanyReviewsNotifier() : super(GetMyCompanyReviewsInitialState());

//   int _round = 1;

//   void getMyCompanyReviews() async {
//     // get current items in the state
//     List<CompanyReview> currentCompanyReviews = [];
//     final currentState = state;
//     if (currentState is GetMyCompanyReviewsLoadedState) {
//       currentCompanyReviews = currentState.infiniteScrollingItems;
//     }
//     // send the request
//     state = GetMyCompanyReviewsLoadingState();
//     final response = await GetIt.I<Repository>().getMyCompanyReviews(_round);
//     response.fold(
//       // deal with failure
//       (failure) => state = GetMyCompanyReviewsErrorState(failure: failure),
//       (companyReviews) {
//         // add items and rounds ended state to the loaded state
//         bool roundsEnded = companyReviews.isEmpty;
//         List<CompanyReview> newCompanyReviews = [
//           ...currentCompanyReviews,
//           ...companyReviews
//         ];
//         state = GetMyCompanyReviewsLoadedState(
//           infiniteScrollingItems: newCompanyReviews,
//           roundsEnded: roundsEnded,
//         );
//         // increment rounds
//         _round++;
//       },
//     );
//   }
// }
