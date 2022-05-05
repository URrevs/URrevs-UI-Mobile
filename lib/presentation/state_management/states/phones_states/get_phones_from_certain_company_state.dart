import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetPhonesFromCertainCompanyState extends Equatable
    implements RequestState {}

class GetPhonesFromCertainCompanyInitialState
    extends GetPhonesFromCertainCompanyState implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetPhonesFromCertainCompanyLoadingState
    extends GetPhonesFromCertainCompanyState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetPhonesFromCertainCompanyLoadedState
    extends GetPhonesFromCertainCompanyState implements LoadedState {
  final List<Phone> phones;
  final bool roundsEnded;

  GetPhonesFromCertainCompanyLoadedState({
    required this.phones,
    required this.roundsEnded,
  });
  @override
  List<Object?> get props => [];
}

class GetPhonesFromCertainCompanyErrorState
    extends GetPhonesFromCertainCompanyState implements ErrorState {
  @override
  final Failure failure;
  GetPhonesFromCertainCompanyErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
