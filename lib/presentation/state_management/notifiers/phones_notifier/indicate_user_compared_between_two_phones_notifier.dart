import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/indicate_user_compared_between_two_phones_state.dart';

class IndicateUserComparedBetweenTwoPhonesNotifier
    extends StateNotifier<IndicateUserComparedBetweenTwoPhonesState> {
  IndicateUserComparedBetweenTwoPhonesNotifier()
      : super(IndicateUserComparedBetweenTwoPhonesInitialState());

  void indicateUserComparedBetweenTwoPhones(
      String phoneId1, String phoneId2) async {
    state = IndicateUserComparedBetweenTwoPhonesLoadingState();
    final response = await GetIt.I<Repository>()
        .indicateUserComparedBetweenTwoPhones(phoneId1, phoneId2);
    response.fold(
      (failure) => state =
          IndicateUserComparedBetweenTwoPhonesErrorState(failure: failure),
      (_) {
        state = IndicateUserComparedBetweenTwoPhonesLoadedState();
      },
    );
  }
}
