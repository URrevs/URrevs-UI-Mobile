import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetMyRankInCompetitionState extends Equatable
    implements RequestState {}

class GetMyRankInCompetitionInitialState extends GetMyRankInCompetitionState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetMyRankInCompetitionLoadingState extends GetMyRankInCompetitionState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetMyRankInCompetitionLoadedState extends GetMyRankInCompetitionState
    implements LoadedState {
  final User user;

  GetMyRankInCompetitionLoadedState({required this.user});
  @override
  List<Object?> get props => [];
}

class GetMyRankInCompetitionErrorState extends GetMyRankInCompetitionState
    implements ErrorState {
  @override
  final Failure failure;
  GetMyRankInCompetitionErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
