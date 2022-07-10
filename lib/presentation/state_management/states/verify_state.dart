import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class VerifyState extends Equatable implements RequestState {}

class VerifyInitialState extends VerifyState implements InitialState {
  @override
  List<Object?> get props => [];
}

class VerifyLoadingState extends VerifyState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class VerifyLoadedState extends VerifyState implements LoadedState {
  final double verificationRatio;
  VerifyLoadedState({
    required this.verificationRatio,
  });

  @override
  List<Object?> get props => [];
}

class VerifyErrorState extends VerifyState implements ErrorState {
  @override
  final Failure failure;
  VerifyErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
