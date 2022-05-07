import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetCompanyReviewsOfAnotherUserState extends Equatable
    implements RequestState {}

class GetCompanyReviewsOfAnotherUserInitialState
    extends GetCompanyReviewsOfAnotherUserState implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetCompanyReviewsOfAnotherUserLoadingState
    extends GetCompanyReviewsOfAnotherUserState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetCompanyReviewsOfAnotherUserLoadedState
    extends GetCompanyReviewsOfAnotherUserState
    implements LoadedState, InfiniteScrollingState<CompanyReview> {
  @override
  final List<CompanyReview> infiniteScrollingItems;
  @override
  final bool roundsEnded;

  GetCompanyReviewsOfAnotherUserLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });

  @override
  List<Object?> get props => [];
}

class GetCompanyReviewsOfAnotherUserErrorState
    extends GetCompanyReviewsOfAnotherUserState implements ErrorState {
  @override
  final Failure failure;
  GetCompanyReviewsOfAnotherUserErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
