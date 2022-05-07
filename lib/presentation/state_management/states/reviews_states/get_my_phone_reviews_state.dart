// import 'package:equatable/equatable.dart';

// import 'package:urrevs_ui_mobile/domain/failure.dart';
// import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
// import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

// abstract class GetMyPhoneReviewsState extends Equatable
//     implements RequestState {}

// class GetMyPhoneReviewsInitialState extends GetMyPhoneReviewsState
//     implements InitialState {
//   @override
//   List<Object?> get props => [];
// }

// class GetMyPhoneReviewsLoadingState extends GetMyPhoneReviewsState
//     implements LoadingState {
//   @override
//   List<Object?> get props => [];
// }

// class GetMyPhoneReviewsLoadedState extends GetMyPhoneReviewsState
//     implements LoadedState, InfiniteScrollingState<PhoneReview> {
//   @override
//   final List<PhoneReview> infiniteScrollingItems;
//   @override
//   final bool roundsEnded;

//   GetMyPhoneReviewsLoadedState({
//     required this.infiniteScrollingItems,
//     required this.roundsEnded,
//   });

//   @override
//   List<Object?> get props => [];
// }

// class GetMyPhoneReviewsErrorState extends GetMyPhoneReviewsState
//     implements ErrorState {
//   @override
//   final Failure failure;
//   GetMyPhoneReviewsErrorState({
//     required this.failure,
//   });

//   @override
//   List<Object?> get props => [failure.message];
// }
