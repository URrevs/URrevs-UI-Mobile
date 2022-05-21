import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class AddInteractionState extends Equatable implements RequestState {}

class AddInteractionInitialState extends AddInteractionState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class AddInteractionLoadingState extends AddInteractionState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class AddInteractionLoadedState extends AddInteractionState
    implements LoadedState {
  final String interactionId;
  final DateTime? ownedAt;
  AddInteractionLoadedState({
    required this.interactionId,
    required this.ownedAt,
  });

  @override
  List<Object?> get props => [];
}

class AddInteractionErrorState extends AddInteractionState
    implements ErrorState {
  @override
  final Failure failure;
  AddInteractionErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
