import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetCompanyReviewState extends Equatable implements RequestState {
}

class GetCompanyReviewInitialState extends GetCompanyReviewState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetCompanyReviewLoadingState extends GetCompanyReviewState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetCompanyReviewLoadedState extends GetCompanyReviewState
    implements LoadedState {
  final CompanyReview review;

  GetCompanyReviewLoadedState({required this.review});
  @override
  List<Object?> get props => [];
}

class GetCompanyReviewErrorState extends GetCompanyReviewState
    implements ErrorState {
  @override
  final Failure failure;
  GetCompanyReviewErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
