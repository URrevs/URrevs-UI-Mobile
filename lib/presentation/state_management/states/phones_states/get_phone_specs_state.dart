import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/specs.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetPhoneSpecsState extends Equatable implements RequestState {}

class GetPhoneSpecsInitialState extends GetPhoneSpecsState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetPhoneSpecsLoadingState extends GetPhoneSpecsState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetPhoneSpecsLoadedState extends GetPhoneSpecsState
    implements LoadedState {
  final Specs specs;

  GetPhoneSpecsLoadedState({required this.specs});
  @override
  List<Object?> get props => [];
}

class GetPhoneSpecsErrorState extends GetPhoneSpecsState implements ErrorState {
  @override
  final Failure failure;
  GetPhoneSpecsErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
