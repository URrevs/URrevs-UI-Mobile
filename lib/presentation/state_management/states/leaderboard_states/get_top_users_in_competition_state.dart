import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetTopUsersInCompetitionState extends Equatable
    implements RequestState {}

class GetTopUsersInCompetitionInitialState extends GetTopUsersInCompetitionState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetTopUsersInCompetitionLoadingState extends GetTopUsersInCompetitionState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetTopUsersInCompetitionLoadedState extends GetTopUsersInCompetitionState
    implements LoadedState {
  final List<User> users;

  GetTopUsersInCompetitionLoadedState({required this.users});
  @override
  List<Object?> get props => [];
}

class GetTopUsersInCompetitionErrorState extends GetTopUsersInCompetitionState
    implements ErrorState {
  @override
  final Failure failure;
  GetTopUsersInCompetitionErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
