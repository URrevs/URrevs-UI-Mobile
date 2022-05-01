import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_owned_phones_state.dart';

class GetMyOwnedPhonesNotifier extends StateNotifier<GetMyOwnedPhonesState> {
  GetMyOwnedPhonesNotifier() : super(GetMyOwnedPhonesInitialState());

  int _round = 0;

  void getMyOwnedPhones() async {
    List<Phone> currentPhones = [];
    final currentState = state;
    if (currentState is GetMyOwnedPhonesLoadedState) {
      currentPhones = currentState.phones;
    }
    state = GetMyOwnedPhonesLoadingState();
    final response = await GetIt.I<Repository>().getMyOwnedPhones(_round);
    response.fold(
      (failure) => state = GetMyOwnedPhonesErrorState(failure: failure),
      (phones) {
        bool roundsEnded = phones.isEmpty;
        List<Phone> newPhones = [...currentPhones, ...phones];
        state = GetMyOwnedPhonesLoadedState(
          phones: newPhones,
          roundsEnded: roundsEnded,
        );
      },
    );
    _round++;
  }
}
