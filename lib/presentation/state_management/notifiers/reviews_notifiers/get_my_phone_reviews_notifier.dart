// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get_it/get_it.dart';
// import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
// import 'package:urrevs_ui_mobile/domain/repository.dart';

// import '../../states/reviews_states/get_my_phone_reviews_state.dart';

// class GetMyPhoneReviewsNotifier extends StateNotifier<GetMyPhoneReviewsState> {
//   GetMyPhoneReviewsNotifier() : super(GetMyPhoneReviewsInitialState());

//   int _round = 1;

//   void getMyPhoneReviews() async {
//     // get current items in the state
//     List<PhoneReview> currentPhoneReviews = [];
//     final currentState = state;
//     if (currentState is GetMyPhoneReviewsLoadedState) {
//       currentPhoneReviews = currentState.infiniteScrollingItems;
//     }
//     // send the request
//     state = GetMyPhoneReviewsLoadingState();
//     final response = await GetIt.I<Repository>().getMyPhoneReviews(_round);
//     response.fold(
//       // deal with failure
//       (failure) => state = GetMyPhoneReviewsErrorState(failure: failure),
//       (phoneReviews) {
//         // add items and rounds ended state to the loaded state
//         bool roundsEnded = phoneReviews.isEmpty;
//         List<PhoneReview> newPhoneReviews = [
//           ...currentPhoneReviews,
//           ...phoneReviews
//         ];
//         state = GetMyPhoneReviewsLoadedState(
//           infiniteScrollingItems: newPhoneReviews,
//           roundsEnded: roundsEnded,
//         );
//         // increment rounds
//         _round++;
//       },
//     );
//   }
// }
