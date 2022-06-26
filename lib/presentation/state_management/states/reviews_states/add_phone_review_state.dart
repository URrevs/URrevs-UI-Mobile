import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class AddPhoneReviewState extends Equatable implements RequestState {}

class AddPhoneReviewInitialState extends AddPhoneReviewState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class AddPhoneReviewLoadingState extends AddPhoneReviewState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class AddPhoneReviewLoadedState extends AddPhoneReviewState
    implements LoadedState {
  final PhoneReview phoneReview;
  final int earnedPoints;

  AddPhoneReviewLoadedState({
    required this.phoneReview,
    required this.earnedPoints,
  });
  @override
  List<Object?> get props => [];
}

class AddPhoneReviewErrorState extends AddPhoneReviewState
    implements ErrorState {
  @override
  final Failure failure;
  AddPhoneReviewErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
