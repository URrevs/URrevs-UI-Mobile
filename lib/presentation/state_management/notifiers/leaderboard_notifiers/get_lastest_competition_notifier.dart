import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/leaderboard_states/get_lastest_competition_state.dart';

class GetLatestCompetitionNotifier
    extends StateNotifier<GetLatestCompetitionState> {
  GetLatestCompetitionNotifier() : super(GetLatestCompetitionInitialState());

  Future<void> getLatestCompetition() async {
    state = GetLatestCompetitionLoadingState();
    final response = await GetIt.I<Repository>().getLatestCompetition();
    response.fold(
      (failure) {
        if (failure is NoResultFailure) {
          return state = GetLatestCompetitionNoResultState();
        }
        state = GetLatestCompetitionErrorState(failure: failure);
      },
      (competition) {
        state = GetLatestCompetitionLoadedState(competition: competition);
      },
    );
  }
}
