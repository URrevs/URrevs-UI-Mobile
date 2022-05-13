import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetUserPhoneReviewsState extends Equatable
    implements RequestState {}

class GetUserPhoneReviewsInitialState extends GetUserPhoneReviewsState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetUserPhoneReviewsLoadingState extends GetUserPhoneReviewsState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetUserPhoneReviewsLoadedState extends GetUserPhoneReviewsState
    implements LoadedState, InfiniteScrollingState<Post> {
  @override
  final List<Post> infiniteScrollingItems;
  @override
  final bool roundsEnded;

  GetUserPhoneReviewsLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });

  @override
  List<Object?> get props => [];
}

class GetUserPhoneReviewsErrorState extends GetUserPhoneReviewsState
    implements ErrorState {
  @override
  final Failure failure;
  GetUserPhoneReviewsErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
