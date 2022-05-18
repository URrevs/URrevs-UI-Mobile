import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetPostsListState extends Equatable
    implements RequestState {}

class GetPostsListInitialState extends GetPostsListState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetPostsListLoadingState extends GetPostsListState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetPostsListLoadedState extends GetPostsListState
    implements LoadedState, InfiniteScrollingState<Post> {
  @override
  final List<Post> infiniteScrollingItems;
  @override
  final bool roundsEnded;

  GetPostsListLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });

  @override
  List<Object?> get props => [];
}

class GetPostsListErrorState extends GetPostsListState
    implements ErrorState {
  @override
  final Failure failure;
  GetPostsListErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
