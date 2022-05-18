import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';

import '../../states/companies_states/get_company_statistical_info_state.dart';

class GetCompanyStatisticalInfoNotifier
    extends StateNotifier<GetCompanyStatisticalInfoState> {
  GetCompanyStatisticalInfoNotifier()
      : super(GetCompanyStatisticalInfoInitialState());

  void getCompanyStatisticalInfo(String companyId) async {
    state = GetCompanyStatisticalInfoLoadingState();
    final response =
        await GetIt.I<Repository>().getCompanyStatisticalInfo(companyId);
    response.fold(
      (failure) =>
          state = GetCompanyStatisticalInfoErrorState(failure: failure),
      (companyStats) {
        state =
            GetCompanyStatisticalInfoLoadedState(companyStats: companyStats);
      },
    );
  }
}
