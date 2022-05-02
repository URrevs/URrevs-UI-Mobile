import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';

abstract class GivePointsToUserState extends Equatable {}

class GivePointsToUserInitialState extends GivePointsToUserState {
  @override
  List<Object?> get props => [];
}

class GivePointsToUserLoadingState extends GivePointsToUserState {
  @override
  List<Object?> get props => [];
}

class GivePointsToUserLoadedState extends GivePointsToUserState {
  @override
  List<Object?> get props => [];
}

class GivePointsToUserErrorState extends GivePointsToUserState {
  final Failure failure;
  GivePointsToUserErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
