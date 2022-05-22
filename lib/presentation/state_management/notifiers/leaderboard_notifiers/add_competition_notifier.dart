import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/requests/leaderboard_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/leaderboard_states/add_compeititon_state.dart';

class AddCompetitionNotifier extends StateNotifier<AddCompetitionState> {
  AddCompetitionNotifier() : super(AddCompetitionInitialState());

  void addCompetition(AddCompetitionRequest request) async {
    state = AddCompetitionLoadingState();
    final response = await GetIt.I<Repository>().addCompetition(request);
    response.fold(
      (failure) => state = AddCompetitionErrorState(failure: failure),
      (competitionId) {
        state = AddCompetitionLoadedState(competitionId: competitionId);
      },
    );
  }
}
