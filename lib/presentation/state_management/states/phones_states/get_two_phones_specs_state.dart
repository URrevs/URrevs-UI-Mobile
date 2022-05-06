import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/specs.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetTwoPhonesSpecsState extends Equatable
    implements RequestState {}

class GetTwoPhonesSpecsInitialState extends GetTwoPhonesSpecsState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetTwoPhonesSpecsLoadingState extends GetTwoPhonesSpecsState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetTwoPhonesSpecsLoadedState extends GetTwoPhonesSpecsState
    implements LoadedState {
  final Specs firstPhoneSpecs;
  final Specs secondPhoneSpecs;

  GetTwoPhonesSpecsLoadedState({
    required this.firstPhoneSpecs,
    required this.secondPhoneSpecs,
  });
  @override
  List<Object?> get props => [];
}

class GetTwoPhonesSpecsErrorState extends GetTwoPhonesSpecsState
    implements ErrorState {
  @override
  final Failure failure;
  GetTwoPhonesSpecsErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
