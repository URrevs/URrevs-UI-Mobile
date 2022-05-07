import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/review.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetPhoneReviewState extends Equatable implements RequestState {}

class GetPhoneReviewInitialState extends GetPhoneReviewState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetPhoneReviewLoadingState extends GetPhoneReviewState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetPhoneReviewLoadedState extends GetPhoneReviewState
    implements LoadedState {
  final PhoneReview review;

  GetPhoneReviewLoadedState({required this.review});
  @override
  List<Object?> get props => [];
}

class GetPhoneReviewErrorState extends GetPhoneReviewState
    implements ErrorState {
  @override
  final Failure failure;
  GetPhoneReviewErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
