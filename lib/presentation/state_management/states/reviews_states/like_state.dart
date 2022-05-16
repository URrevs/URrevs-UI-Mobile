import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class LikeState extends Equatable implements RequestState {
  bool get isLiked {
    final state = this;
    if (state is LikeLoadingState && state.liked) return true;
    if (state is LikeLoadedState && state.liked) return true;
    return false;
  }
}

class LikeInitialState extends LikeState implements InitialState {
  @override
  List<Object?> get props => [];
}

class LikeLoadingState extends LikeState implements LoadingState {
  bool liked;
  LikeLoadingState({
    required this.liked,
  });
  @override
  List<Object?> get props => [];
}

class LikeLoadedState extends LikeState implements LoadedState {
  final bool liked;
  LikeLoadedState({
    required this.liked,
  });

  @override
  List<Object?> get props => [];
}

class LikeErrorState extends LikeState implements ErrorState {
  @override
  final Failure failure;
  LikeErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
