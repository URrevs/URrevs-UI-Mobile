import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class AddCompetitionState extends Equatable implements RequestState {}

class AddCompetitionInitialState extends AddCompetitionState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class AddCompetitionLoadingState extends AddCompetitionState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class AddCompetitionLoadedState extends AddCompetitionState
    implements LoadedState {
  final String competitionId;

  AddCompetitionLoadedState({required this.competitionId});
  @override
  List<Object?> get props => [];
}

class AddCompetitionErrorState extends AddCompetitionState
    implements ErrorState {
  @override
  final Failure failure;
  AddCompetitionErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
