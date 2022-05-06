import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_all_phones_state.dart';

class GetAllPhonesNotifier extends StateNotifier<GetAllPhonesState> {
  GetAllPhonesNotifier() : super(GetAllPhonesInitialState());

  int _round = 1;

  String? _previousCompanyId;

  void getPhones([String? companyId]) async {
    List<Phone> currentPhones = [];
    final currentState = state;
    // get previously loaded phones
    if (currentState is GetAllPhonesLoadedState) {
      currentPhones = [...currentState.infiniteScrollingItems];
    }
    // clear previous phones list if company id is different
    if (companyId != _previousCompanyId) {
      currentPhones.clear();
      _round = 1;
    }
    _previousCompanyId = companyId;
    state = GetAllPhonesLoadingState();
    late Either<Failure, List<Phone>> response;
    if (companyId == null) {
      response = await GetIt.I<Repository>().getAllPhones(_round);
    } else {
      response = await GetIt.I<Repository>()
          .getPhonesFromCertainCompany(companyId, _round);
    }
    response.fold(
      (failure) => state = GetAllPhonesErrorState(failure: failure),
      (phones) {
        bool roundsEnded = phones.isEmpty;
        List<Phone> newPhones = [...currentPhones, ...phones];
        state = GetAllPhonesLoadedState(
          infiniteScrollingItems: newPhones,
          roundsEnded: roundsEnded,
        );
        _round++;
      },
    );
  }
}
