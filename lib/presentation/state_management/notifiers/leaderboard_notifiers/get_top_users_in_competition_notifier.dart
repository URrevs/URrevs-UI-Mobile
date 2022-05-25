import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/leaderboard_states/get_top_users_in_competition_state.dart';

class GetTopUsersInCompetitionNotifier
    extends StateNotifier<GetTopUsersInCompetitionState> {
  GetTopUsersInCompetitionNotifier()
      : super(GetTopUsersInCompetitionInitialState());

  void getTopUsersInCompetition() async {
    state = GetTopUsersInCompetitionLoadingState();
    final response = await GetIt.I<Repository>().getTopUsersInCompetition();
    response.fold(
      (failure) => state = GetTopUsersInCompetitionErrorState(failure: failure),
      (users) {
        state = GetTopUsersInCompetitionLoadedState(users: users);
      },
    );
  }
}
