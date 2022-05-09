import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetCommentsState extends Equatable implements RequestState {}

class GetCommentsInitialState extends GetCommentsState implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetCommentsLoadingState extends GetCommentsState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetCommentsLoadedState extends GetCommentsState
    implements LoadedState, InfiniteScrollingState<Comment> {
  @override
  final List<Comment> infiniteScrollingItems;
  @override
  final bool roundsEnded;

  GetCommentsLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });

  @override
  List<Object?> get props => [];
}

class GetCommentsErrorState extends GetCommentsState implements ErrorState {
  @override
  final Failure failure;
  GetCommentsErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
