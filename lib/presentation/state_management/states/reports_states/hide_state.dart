import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class HideState extends Equatable implements RequestState {}

class HideInitialState extends HideState implements InitialState {
  final bool hidden;
  HideInitialState({
    required this.hidden,
  });

  @override
  List<Object?> get props => [];
}

class HideLoadingState extends HideState implements LoadingState {
  final bool hidden;
  HideLoadingState({
    required this.hidden,
  });

  @override
  List<Object?> get props => [];
}

class HideLoadedState extends HideState implements LoadedState {
  final bool hidden;
  HideLoadedState({
    required this.hidden,
  });

  @override
  List<Object?> get props => [];
}

class HideErrorState extends HideState implements ErrorState {
  @override
  final Failure failure;
  HideErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
