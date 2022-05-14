import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetInteractionsState extends Equatable implements RequestState {}

class GetInteractionsInitialState extends GetInteractionsState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetInteractionsLoadingState extends GetInteractionsState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetInteractionsLoadedState extends GetInteractionsState
    implements LoadedState, InfiniteScrollingState<DirectInteraction> {
  @override
  final List<DirectInteraction> infiniteScrollingItems;
  @override
  final bool roundsEnded;

  GetInteractionsLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });

  @override
  List<Object?> get props => [];
}

class GetInteractionsErrorState extends GetInteractionsState
    implements ErrorState {
  @override
  final Failure failure;
  GetInteractionsErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
