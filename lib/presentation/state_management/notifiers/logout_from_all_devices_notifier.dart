import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/logout_from_all_devices_state.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class LogoutFromAllDevicesNotifier
    extends StateNotifier<LogoutFromAllDevicesState> {
  LogoutFromAllDevicesNotifier() : super(LogoutFromAllDevicesInitialState());

  void logoutFromAllDevices() async {
    state = LogoutFromAllDevicesLoadingState();
    final response = await GetIt.I<Repository>().logoutFromAllDevices();
    response.fold(
      (failure) {
        failure.message += '\n' + LocaleKeys.cantLogoutFromAllDevices.tr();
        state = LogoutFromAllDevicesErrorState(failure: failure);
      },
      (_) {
        state = LogoutFromAllDevicesLoadedState();
      },
    );
  }
}
