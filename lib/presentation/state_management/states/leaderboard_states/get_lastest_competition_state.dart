import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/competition.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetLatestCompetitionState extends Equatable
    implements RequestState {}

class GetLatestCompetitionInitialState extends GetLatestCompetitionState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetLatestCompetitionLoadingState extends GetLatestCompetitionState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetLatestCompetitionLoadedState extends GetLatestCompetitionState
    implements LoadedState {
  final Competition competition;

  GetLatestCompetitionLoadedState({required this.competition});
  @override
  List<Object?> get props => [];
}

class GetLatestCompetitionNoResultState extends GetLatestCompetitionState {
  GetLatestCompetitionNoResultState();
  @override
  List<Object?> get props => [];
}

class GetLatestCompetitionErrorState extends GetLatestCompetitionState
    implements ErrorState {
  @override
  final Failure failure;
  GetLatestCompetitionErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
