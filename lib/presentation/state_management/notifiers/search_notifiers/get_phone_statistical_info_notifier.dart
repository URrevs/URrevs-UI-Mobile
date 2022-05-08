import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_phone_statistical_info_state.dart';

class GetPhoneStatisticalInfoNotifier
    extends StateNotifier<GetPhoneStatisticalInfoState> {
  GetPhoneStatisticalInfoNotifier()
      : super(GetPhoneStatisticalInfoInitialState());

  void getPhoneStatisticalInfo(String phoneId) async {
    state = GetPhoneStatisticalInfoLoadingState();
    final response =
        await GetIt.I<Repository>().getPhoneStatisticalInfo(phoneId);
    response.fold(
      (failure) => state = GetPhoneStatisticalInfoErrorState(failure: failure),
      (info) {
        if (mounted) {
          state = GetPhoneStatisticalInfoLoadedState(info: info);
        }
      },
    );
  }
}
