import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class BlockUserState extends Equatable implements RequestState {}

class BlockUserInitialState extends BlockUserState implements InitialState {
  final bool blocked;
  BlockUserInitialState({
    required this.blocked,
  });
  @override
  List<Object?> get props => [];
}

class BlockUserLoadingState extends BlockUserState implements LoadingState {
  final bool blocked;
  BlockUserLoadingState({
    required this.blocked,
  });
  @override
  List<Object?> get props => [];
}

class BlockUserLoadedState extends BlockUserState implements LoadedState {
  final bool blocked;
  BlockUserLoadedState({
    required this.blocked,
  });

  @override
  List<Object?> get props => [];
}

class BlockUserErrorState extends BlockUserState implements ErrorState {
  @override
  final Failure failure;
  BlockUserErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
