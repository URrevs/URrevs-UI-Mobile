import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class LogoutFromAllDevicesState extends Equatable
    implements RequestState {}

class LogoutFromAllDevicesInitialState extends LogoutFromAllDevicesState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class LogoutFromAllDevicesLoadingState extends LogoutFromAllDevicesState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class LogoutFromAllDevicesLoadedState extends LogoutFromAllDevicesState
    implements LoadedState {
  @override
  List<Object?> get props => [];
}

class LogoutFromAllDevicesErrorState extends LogoutFromAllDevicesState
    implements ErrorState {
  @override
  final Failure failure;
  LogoutFromAllDevicesErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
