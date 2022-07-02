import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/interaction.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetReportInteractionState extends Equatable
    implements RequestState {}

class GetReportInteractionInitialState extends GetReportInteractionState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetReportInteractionLoadingState extends GetReportInteractionState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetReportInteractionLoadedState extends GetReportInteractionState
    implements LoadedState {
  final Interaction interaction;

  GetReportInteractionLoadedState({required this.interaction});
  @override
  List<Object?> get props => [];
}

class GetReportInteractionErrorState extends GetReportInteractionState
    implements ErrorState {
  @override
  final Failure failure;
  GetReportInteractionErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}

class GetReportInteractionHiddenState extends GetReportInteractionState {
  final Interaction interaction;

  GetReportInteractionHiddenState({required this.interaction});
  @override
  List<Object?> get props => [];
}
