import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';

import '../../states/phones_states/get_phone_specs_state.dart';

class GetPhoneSpecsNotifier extends StateNotifier<GetPhoneSpecsState> {
  GetPhoneSpecsNotifier() : super(GetPhoneSpecsInitialState());

  void getPhoneSpecs(String phoneId) async {
    state = GetPhoneSpecsLoadingState();
    final response = await GetIt.I<Repository>().getPhoneSpecs(phoneId);
    response.fold(
      (failure) => state = GetPhoneSpecsErrorState(failure: failure),
      (specs) {
        state = GetPhoneSpecsLoadedState(specs: specs);
      },
    );
  }
}
