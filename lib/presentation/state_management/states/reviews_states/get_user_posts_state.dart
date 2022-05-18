import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetUserPostsState extends Equatable
    implements RequestState {}

class GetUserPostsInitialState extends GetUserPostsState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetUserPostsLoadingState extends GetUserPostsState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetUserPostsLoadedState extends GetUserPostsState
    implements LoadedState, InfiniteScrollingState<Post> {
  @override
  final List<Post> infiniteScrollingItems;
  @override
  final bool roundsEnded;

  GetUserPostsLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });

  @override
  List<Object?> get props => [];
}

class GetUserPostsErrorState extends GetUserPostsState
    implements ErrorState {
  @override
  final Failure failure;
  GetUserPostsErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
