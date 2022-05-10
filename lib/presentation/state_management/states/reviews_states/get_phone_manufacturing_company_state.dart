import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetPhoneManufacturingCompanyState extends Equatable
    implements RequestState {}

class GetPhoneManufacturingCompanyInitialState
    extends GetPhoneManufacturingCompanyState implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetPhoneManufacturingCompanyLoadingState
    extends GetPhoneManufacturingCompanyState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetPhoneManufacturingCompanyLoadedState
    extends GetPhoneManufacturingCompanyState implements LoadedState {
  final Company company;

  GetPhoneManufacturingCompanyLoadedState({required this.company});
  @override
  List<Object?> get props => [];
}

class GetPhoneManufacturingCompanyErrorState
    extends GetPhoneManufacturingCompanyState implements ErrorState {
  @override
  final Failure failure;
  GetPhoneManufacturingCompanyErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
