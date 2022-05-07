import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetMyCompanyReviewsState extends Equatable
    implements RequestState {}

class GetMyCompanyReviewsInitialState extends GetMyCompanyReviewsState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetMyCompanyReviewsLoadingState extends GetMyCompanyReviewsState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetMyCompanyReviewsLoadedState extends GetMyCompanyReviewsState
    implements LoadedState, InfiniteScrollingState<CompanyReview> {
  @override
  final List<CompanyReview> infiniteScrollingItems;
  @override
  final bool roundsEnded;

  GetMyCompanyReviewsLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });

  @override
  List<Object?> get props => [];
}

class GetMyCompanyReviewsErrorState extends GetMyCompanyReviewsState
    implements ErrorState {
  @override
  final Failure failure;
  GetMyCompanyReviewsErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
