import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class AcceptAnswerState extends Equatable implements RequestState {
  bool get isAccepted {
    final state = this;
    if (state is AcceptAnswerLoadingState && state.accepted) return true;
    if (state is AcceptAnswerLoadedState && state.accepted) return true;
    return false;
  }
}

class AcceptAnswerInitialState extends AcceptAnswerState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class AcceptAnswerLoadingState extends AcceptAnswerState
    implements LoadingState {
  final bool accepted;
  AcceptAnswerLoadingState({
    required this.accepted,
  });
  @override
  List<Object?> get props => [];
}

class AcceptAnswerLoadedState extends AcceptAnswerState implements LoadedState {
  final bool accepted;
  AcceptAnswerLoadedState({
    required this.accepted,
  });
  @override
  List<Object?> get props => [];
}

class AcceptAnswerErrorState extends AcceptAnswerState implements ErrorState {
  @override
  final Failure failure;
  AcceptAnswerErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
