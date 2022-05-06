import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';

import '../../states/phones_states/get_similar_phones_state.dart';

class GetSimilarPhonesNotifier extends StateNotifier<GetSimilarPhonesState> {
  GetSimilarPhonesNotifier() : super(GetSimilarPhonesInitialState());

  void getSimilarPhones(String phoneId) async {
    state = GetSimilarPhonesLoadingState();
    final response = await GetIt.I<Repository>().getSimilarPhones(phoneId);
    response.fold(
      (failure) => state = GetSimilarPhonesErrorState(failure: failure),
      (phones) {
        state = GetSimilarPhonesLoadedState(phones: phones);
      },
    );
  }
}
