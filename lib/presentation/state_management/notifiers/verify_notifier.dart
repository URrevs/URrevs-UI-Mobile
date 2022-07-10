import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/verify_state.dart';

class VerifyNotifier extends StateNotifier<VerifyState> {
  VerifyNotifier({required this.phoneId}) : super(VerifyInitialState());

  final String phoneId;

  void verifyPhone() async {
    state = VerifyLoadingState();
    final response = await GetIt.I<Repository>().verifyPhone(phoneId);
    response.fold(
      (failure) => state = VerifyErrorState(failure: failure),
      (verificationRatio) {
        state = VerifyLoadedState(verificationRatio: verificationRatio);
      },
    );
  }

  void verifyPhoneReview(String reviewId) async {
    state = VerifyLoadingState();
    final response = await GetIt.I<Repository>().verifyPhoneReview(reviewId);
    response.fold(
      (failure) => state = VerifyErrorState(failure: failure),
      (verificationRatio) {
        state = VerifyLoadedState(verificationRatio: verificationRatio);
      },
    );
  }
}
