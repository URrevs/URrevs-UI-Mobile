import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetReviewsOnCertainPhoneState extends Equatable
    implements RequestState {}

class GetReviewsOnCertainPhoneInitialState extends GetReviewsOnCertainPhoneState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetReviewsOnCertainPhoneLoadingState extends GetReviewsOnCertainPhoneState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetReviewsOnCertainPhoneLoadedState extends GetReviewsOnCertainPhoneState
    implements LoadedState, InfiniteScrollingState<PhoneReview> {
  @override
  final List<PhoneReview> infiniteScrollingItems;
  @override
  final bool roundsEnded;

  GetReviewsOnCertainPhoneLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });

  @override
  List<Object?> get props => [];
}

class GetReviewsOnCertainPhoneErrorState extends GetReviewsOnCertainPhoneState
    implements ErrorState {
  @override
  final Failure failure;
  GetReviewsOnCertainPhoneErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
