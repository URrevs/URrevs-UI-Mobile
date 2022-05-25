import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/leaderboard_states/get_my_rank_in_competition_state.dart';

class GetMyRankInCompetitionNotifier
    extends StateNotifier<GetMyRankInCompetitionState> {
  GetMyRankInCompetitionNotifier()
      : super(GetMyRankInCompetitionInitialState());

  void getMyRankInCompetition() async {
    state = GetMyRankInCompetitionLoadingState();
    final response = await GetIt.I<Repository>().getMyRankInCompetition();
    response.fold(
      (failure) => state = GetMyRankInCompetitionErrorState(failure: failure),
      (user) {
        state = GetMyRankInCompetitionLoadedState(user: user);
      },
    );
  }
}
