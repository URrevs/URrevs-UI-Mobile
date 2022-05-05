import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/companies_states/get_all_companies_state.dart';

class GetAllCompaniesNotifier extends StateNotifier<GetAllCompaniesState> {
  GetAllCompaniesNotifier() : super(GetAllCompaniesInitialState());

  void getAllCompanies(int round) async {
    state = GetAllCompaniesLoadingState();
    final response = await GetIt.I<Repository>().getAllCompanies(round);
    response.fold(
      (failure) => state = GetAllCompaniesErrorState(failure: failure),
      (companies) {
        state = GetAllCompaniesLoadedState(companies: companies);
      },
    );
  }
}
