import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company_stats.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetCompanyStatisticalInfoState extends Equatable
    implements RequestState {}

class GetCompanyStatisticalInfoInitialState
    extends GetCompanyStatisticalInfoState implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetCompanyStatisticalInfoLoadingState
    extends GetCompanyStatisticalInfoState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetCompanyStatisticalInfoLoadedState
    extends GetCompanyStatisticalInfoState implements LoadedState {
  final CompanyStats companyStats;

  GetCompanyStatisticalInfoLoadedState({required this.companyStats});
  @override
  List<Object?> get props => [];
}

class GetCompanyStatisticalInfoErrorState extends GetCompanyStatisticalInfoState
    implements ErrorState {
  @override
  final Failure failure;
  GetCompanyStatisticalInfoErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
