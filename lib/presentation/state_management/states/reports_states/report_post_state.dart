import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class ReportPostState extends Equatable implements RequestState {}

class ReportPostInitialState extends ReportPostState implements InitialState {
  @override
  List<Object?> get props => [];
}

class ReportPostLoadingState extends ReportPostState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class ReportPostLoadedState extends ReportPostState implements LoadedState {
  @override
  List<Object?> get props => [];
}

class ReportPostErrorState extends ReportPostState implements ErrorState {
  @override
  final Failure failure;
  ReportPostErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
