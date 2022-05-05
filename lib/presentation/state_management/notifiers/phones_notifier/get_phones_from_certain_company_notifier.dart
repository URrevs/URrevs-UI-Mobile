import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_phones_from_certain_company_state.dart';

class GetPhonesFromCertainCompanyNotifier
    extends StateNotifier<GetPhonesFromCertainCompanyState> {
  GetPhonesFromCertainCompanyNotifier()
      : super(GetPhonesFromCertainCompanyInitialState());

  int _round = 1;

  void getPhonesFromCertainCompany(String companyId) async {
    List<Phone> currentPhones = [];
    final currentState = state;
    if (currentState is GetPhonesFromCertainCompanyLoadedState) {
      currentPhones = currentState.phones;
    }
    state = GetPhonesFromCertainCompanyLoadingState();
    final response = await GetIt.I<Repository>()
        .getPhonesFromCertainCompany(companyId, _round);
    response.fold(
      (failure) =>
          state = GetPhonesFromCertainCompanyErrorState(failure: failure),
      (phones) {
        bool roundsEnded = phones.isEmpty;
        List<Phone> newPhones = [...currentPhones, ...phones];
        state = GetPhonesFromCertainCompanyLoadedState(
          phones: newPhones,
          roundsEnded: roundsEnded,
        );
        _round++;
      },
    );
  }
}
