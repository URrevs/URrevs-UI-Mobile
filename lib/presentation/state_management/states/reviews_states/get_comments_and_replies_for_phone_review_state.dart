import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetCommentsAndRepliesForPhoneReviewState extends Equatable
    implements RequestState {}

class GetCommentsAndRepliesForPhoneReviewInitialState
    extends GetCommentsAndRepliesForPhoneReviewState implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetCommentsAndRepliesForPhoneReviewLoadingState
    extends GetCommentsAndRepliesForPhoneReviewState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetCommentsAndRepliesForPhoneReviewLoadedState
    extends GetCommentsAndRepliesForPhoneReviewState
    implements LoadedState, InfiniteScrollingState<Comment> {
  @override
  final List<Comment> infiniteScrollingItems;
  @override
  final bool roundsEnded;

  GetCommentsAndRepliesForPhoneReviewLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });

  @override
  List<Object?> get props => [];
}

class GetCommentsAndRepliesForPhoneReviewErrorState
    extends GetCommentsAndRepliesForPhoneReviewState implements ErrorState {
  @override
  final Failure failure;
  GetCommentsAndRepliesForPhoneReviewErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
