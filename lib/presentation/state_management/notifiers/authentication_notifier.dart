import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  AuthenticationNotifier() : super(AuthenticationInitialState());

  void authenticateWithGoogle() async {
    state = AuthenticationLoadingState();
    final response = await GetIt.I<Repository>().authenticateWithGoogle();
    response.fold(
      (failure) {
        if (failure.mode == FailureMode.cancel) {
          return state = AuthenticationInitialState();
        }
        state = AuthenticationErrorState(failure: failure);
      },
      (r) => state = AuthenticationLoadedState(),
    );
  }
}
