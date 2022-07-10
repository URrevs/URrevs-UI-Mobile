import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_stats.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_phone_statistical_info_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/verify_state.dart';

class GetPhoneStatisticalInfoNotifier
    extends StateNotifier<GetPhoneStatisticalInfoState> {
  GetPhoneStatisticalInfoNotifier({required this.ref})
      : super(GetPhoneStatisticalInfoInitialState());

  final AutoDisposeStateNotifierProviderRef ref;

  void getPhoneStatisticalInfo(String phoneId) async {
    state = GetPhoneStatisticalInfoLoadingState();
    final response =
        await GetIt.I<Repository>().getPhoneStatisticalInfo(phoneId);
    response.fold(
      (failure) => state = GetPhoneStatisticalInfoErrorState(failure: failure),
      (info) {
        if (mounted) {
          state = GetPhoneStatisticalInfoLoadedState(info: info);
          _addListenerToVerifyProvider(phoneId, info);
        }
      },
    );
  }

  void _addListenerToVerifyProvider(String phoneId, PhoneStats info) {
    final authState =
        ref.watch(authenticationProvider) as AuthenticationLoadedState;
    String userId = authState.user.id;
    VerifyProviderParams params = VerifyProviderParams(
      phoneId: phoneId,
      userId: userId,
    );
    ref.listen(verifyProvider(params), (previous, next) {
      if (next is VerifyLoadedState) {
        state = GetPhoneStatisticalInfoLoadedState(
            info: info.copyWith(verificationRatio: next.verificationRatio));
      }
    });
  }
}
