import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  AuthenticationNotifier() : super(AuthenticationInitialState());

  /// Used to login user automatically when he is logged i using firebase.
  void loginToOurBackend() async {
    state = AuthenticationLoadingState();
    final response = await GetIt.I<Repository>().loginToOurBackend();
    response.fold((failure) {
      if (failure is CancelFailure) {
        return state = AuthenticationInitialState();
      }
      state = AuthenticationErrorState(failure: failure);
    }, (returnedVals) {
      return state = AuthenticationLoadedState(
        user: returnedVals.user,
        refCode: returnedVals.refCode,
      );
    });
  }

  void authenticateWithGoogle() async {
    state = AuthenticationLoadingState();
    final response = await GetIt.I<Repository>().authenticateWithGoogle();
    response.fold((failure) {
      if (failure is CancelFailure) {
        return state = AuthenticationInitialState();
      }
      state = AuthenticationErrorState(failure: failure);
    }, (returnedVals) {
      return state = AuthenticationLoadedState(
        user: returnedVals.user,
        refCode: returnedVals.refCode,
      );
    });
  }

  void authenticateWithFacebook() async {
    state = AuthenticationLoadingState();
    final response = await GetIt.I<Repository>().authenticateWithFacebook();
    response.fold((failure) {
      if (failure is CancelFailure) {
        return state = AuthenticationInitialState();
      }
      state = AuthenticationErrorState(failure: failure);
    }, (returnedVals) {
      return state = AuthenticationLoadedState(
        user: returnedVals.user,
        refCode: returnedVals.refCode,
      );
    });
  }
}
