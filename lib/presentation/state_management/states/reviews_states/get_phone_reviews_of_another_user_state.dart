// import 'package:equatable/equatable.dart';

// import 'package:urrevs_ui_mobile/domain/failure.dart';
// import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
// import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

// abstract class GetPhoneReviewsOfAnotherUserState extends Equatable
//     implements RequestState {}

// class GetPhoneReviewsOfAnotherUserInitialState
//     extends GetPhoneReviewsOfAnotherUserState implements InitialState {
//   @override
//   List<Object?> get props => [];
// }

// class GetPhoneReviewsOfAnotherUserLoadingState
//     extends GetPhoneReviewsOfAnotherUserState implements LoadingState {
//   @override
//   List<Object?> get props => [];
// }

// class GetPhoneReviewsOfAnotherUserLoadedState
//     extends GetPhoneReviewsOfAnotherUserState
//     implements LoadedState, InfiniteScrollingState<PhoneReview> {
//   @override
//   final List<PhoneReview> infiniteScrollingItems;
//   @override
//   final bool roundsEnded;
//   GetPhoneReviewsOfAnotherUserLoadedState({
//     required this.infiniteScrollingItems,
//     required this.roundsEnded,
//   });
//   @override
//   List<Object?> get props => [];
// }

// class GetPhoneReviewsOfAnotherUserErrorState
//     extends GetPhoneReviewsOfAnotherUserState implements ErrorState {
//   @override
//   final Failure failure;
//   GetPhoneReviewsOfAnotherUserErrorState({
//     required this.failure,
//   });

//   @override
//   List<Object?> get props => [failure.message];
// }
