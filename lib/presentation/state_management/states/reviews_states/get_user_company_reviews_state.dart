import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetUserCompanyReviewsState extends Equatable
    implements RequestState {}

class GetUserCompanyReviewsInitialState extends GetUserCompanyReviewsState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetUserCompanyReviewsLoadingState extends GetUserCompanyReviewsState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetUserCompanyReviewsLoadedState extends GetUserCompanyReviewsState
    implements LoadedState, InfiniteScrollingState<CompanyReview> {
  @override
  final List<CompanyReview> infiniteScrollingItems;
  @override
  final bool roundsEnded;

  GetUserCompanyReviewsLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });

  @override
  List<Object?> get props => [];
}

class GetUserCompanyReviewsErrorState extends GetUserCompanyReviewsState
    implements ErrorState {
  @override
  final Failure failure;
  GetUserCompanyReviewsErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
