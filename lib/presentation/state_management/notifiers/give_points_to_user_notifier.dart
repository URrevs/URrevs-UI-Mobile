import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/give_points_to_user_state.dart';

class GivePointsToUserNotifier extends StateNotifier<GivePointsToUserState> {
  GivePointsToUserNotifier() : super(GivePointsToUserInitialState());

  void givePointsToUser() async {
    state = GivePointsToUserLoadingState();
    final response = await GetIt.I<Repository>().givePointsToUser();
    response.fold(
      (failure) {
        state = GivePointsToUserErrorState(failure: failure);
      },
      (_) {
        state = GivePointsToUserLoadedState();
      },
    );
  }
}
