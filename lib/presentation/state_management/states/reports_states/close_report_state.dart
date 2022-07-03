import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class CloseReportState extends Equatable implements RequestState {}

class CloseReportInitialState extends CloseReportState implements InitialState {
  @override
  List<Object?> get props => [];
}

class CloseReportLoadingState extends CloseReportState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class CloseReportLoadedState extends CloseReportState implements LoadedState {
  @override
  List<Object?> get props => [];
}

class CloseReportErrorState extends CloseReportState implements ErrorState {
  @override
  final Failure failure;
  CloseReportErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
