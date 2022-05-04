import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';

abstract class UpdateTargetsFromSourceState extends Equatable {}

class UpdateTargetsFromSourceInitialState extends UpdateTargetsFromSourceState {
  @override
  List<Object?> get props => [];
}

class UpdateTargetsFromSourceLoadingState extends UpdateTargetsFromSourceState {
  @override
  List<Object?> get props => [];
}

class UpdateTargetsFromSourceLoadedState extends UpdateTargetsFromSourceState {
  @override
  List<Object?> get props => [];
}

class UpdateTargetsFromSourceErrorState extends UpdateTargetsFromSourceState {
  final Failure failure;
  UpdateTargetsFromSourceErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
