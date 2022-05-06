import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/info.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetPhoneStatisticalInfoState extends Equatable
    implements RequestState {}

class GetPhoneStatisticalInfoInitialState extends GetPhoneStatisticalInfoState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetPhoneStatisticalInfoLoadingState extends GetPhoneStatisticalInfoState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetPhoneStatisticalInfoLoadedState extends GetPhoneStatisticalInfoState
    implements LoadedState {
  final Info info;

  GetPhoneStatisticalInfoLoadedState({required this.info});
  @override
  List<Object?> get props => [];
}

class GetPhoneStatisticalInfoErrorState extends GetPhoneStatisticalInfoState
    implements ErrorState {
  @override
  final Failure failure;
  GetPhoneStatisticalInfoErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
