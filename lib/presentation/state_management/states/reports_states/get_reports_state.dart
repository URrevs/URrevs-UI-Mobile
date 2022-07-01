import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetReportsState extends Equatable implements RequestState {}

class GetReportsInitialState extends GetReportsState implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetReportsLoadingState extends GetReportsState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetReportsLoadedState extends GetReportsState
    implements LoadedState, InfiniteScrollingState<Report> {
  @override
  final List<Report> infiniteScrollingItems;
  @override
  final bool roundsEnded;

  GetReportsLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });

  @override
  List<Object?> get props => [];
}

class GetReportsErrorState extends GetReportsState implements ErrorState {
  @override
  final Failure failure;
  GetReportsErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
