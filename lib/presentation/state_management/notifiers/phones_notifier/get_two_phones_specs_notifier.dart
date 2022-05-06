import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_two_phones_specs_state.dart';

class GetTwoPhonesSpecsNotifier extends StateNotifier<GetTwoPhonesSpecsState> {
  GetTwoPhonesSpecsNotifier() : super(GetTwoPhonesSpecsInitialState());

  void getTwoPhonesSpecs(String firstPhoneId, String secondPhoneId) async {
    state = GetTwoPhonesSpecsLoadingState();
    final response = await GetIt.I<Repository>()
        .getTwoPhonesSpecs(firstPhoneId, secondPhoneId);
    response.fold(
      (failure) => state = GetTwoPhonesSpecsErrorState(failure: failure),
      (specsList) {
        state = GetTwoPhonesSpecsLoadedState(
          firstPhoneSpecs: specsList[0],
          secondPhoneSpecs: specsList[1],
        );
      },
    );
  }
}
