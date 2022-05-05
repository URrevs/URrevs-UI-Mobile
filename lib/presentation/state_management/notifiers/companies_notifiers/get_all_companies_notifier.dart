import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/companies_states/get_all_companies_state.dart';

class GetAllCompaniesNotifier extends StateNotifier<GetAllCompaniesState> {
  GetAllCompaniesNotifier() : super(GetAllCompaniesInitialState());

  int _round = 1;

  void getAllCompanies() async {
    // get current items in the state
    List<Company> currentCompanies = [];
    final currentState = state;
    if (currentState is GetAllCompaniesLoadedState) {
      currentCompanies = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetAllCompaniesLoadingState();
    final response = await GetIt.I<Repository>().getAllCompanies(_round);
    response.fold(
      // deal with failure
      (failure) => state = GetAllCompaniesErrorState(failure: failure),
      (companies) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = companies.isEmpty;
        List<Company> newCompanies = [...currentCompanies, ...companies];
        state = GetAllCompaniesLoadedState(
          infiniteScrollingItems: newCompanies,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
        print(state);
      },
    );
  }
}
