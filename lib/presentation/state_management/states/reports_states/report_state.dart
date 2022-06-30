import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class ReportState extends Equatable implements RequestState {}

class ReportInitialState extends ReportState implements InitialState {
  @override
  List<Object?> get props => [];
}

class ReportLoadingState extends ReportState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class ReportLoadedState extends ReportState implements LoadedState {
  @override
  List<Object?> get props => [];
}

class ReportErrorState extends ReportState implements ErrorState {
  @override
  final Failure failure;
  ReportErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
