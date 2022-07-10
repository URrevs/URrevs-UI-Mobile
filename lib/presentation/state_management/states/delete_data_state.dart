import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class DeleteDataState extends Equatable implements RequestState {}

class DeleteDataInitialState extends DeleteDataState implements InitialState {
  final bool requested;
  DeleteDataInitialState({
    required this.requested,
  });
  @override
  List<Object?> get props => [];
}

class DeleteDataLoadingState extends DeleteDataState implements LoadingState {
  final bool requested;
  DeleteDataLoadingState({
    required this.requested,
  });

  @override
  List<Object?> get props => [];
}

class DeleteDataLoadedState extends DeleteDataState implements LoadedState {
  final bool requested;
  DeleteDataLoadedState({
    required this.requested,
  });

  @override
  List<Object?> get props => [];
}

class DeleteDataErrorState extends DeleteDataState implements ErrorState {
  @override
  final Failure failure;
  DeleteDataErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
