import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class IDontLikeThisState extends Equatable implements RequestState {}

class IDontLikeThisInitialState extends IDontLikeThisState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class IDontLikeThisLoadingState extends IDontLikeThisState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class IDontLikeThisLoadedState extends IDontLikeThisState
    implements LoadedState {
  @override
  List<Object?> get props => [];
}

class IDontLikeThisErrorState extends IDontLikeThisState implements ErrorState {
  @override
  final Failure failure;
  IDontLikeThisErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
