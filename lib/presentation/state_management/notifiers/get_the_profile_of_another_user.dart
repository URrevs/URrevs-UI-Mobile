import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_the_profile_of_another_user_state.dart';

class GetTheProfileOfAnotherUserNotifier
    extends StateNotifier<GetTheProfileOfAnotherUserState> {
  GetTheProfileOfAnotherUserNotifier()
      : super(GetTheProfileOfAnotherUserInitialState());

  void getTheProfileOfAnotherUser(String userId) async {
    state = GetTheProfileOfAnotherUserLoadingState();
    final response =
        await GetIt.I<Repository>().getTheProfileOfAnotherUser(userId);
    response.fold(
      (failure) =>
          state = GetTheProfileOfAnotherUserErrorState(failure: failure),
      (user) {
        state = GetTheProfileOfAnotherUserLoadedState(user: user);
      },
    );
  }
}
