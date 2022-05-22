import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/responses/update_api_responses.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_info_about_latest_update_state.dart';

class GetInfoAboutLatestUpdateNotifier
    extends StateNotifier<GetInfoAboutLatestUpdateState> {
  GetInfoAboutLatestUpdateNotifier()
      : super(GetInfoAboutLatestUpdateInitialState());

  void getInfoAboutLatestUpdate() async {
    state = GetInfoAboutLatestUpdateLoadingState();
    final response = await GetIt.I<Repository>().getInfoAboutLatestUpdate();
    response.fold(
      (failure) {
        if (failure is NoResultFailure) {
          return state = GetInfoAboutLatestUpdateNoUpdateState();
        }
        state = GetInfoAboutLatestUpdateErrorState(failure: failure);
      },
      (GetInfoAboutLatestUpdateResponse response) {
        state = GetInfoAboutLatestUpdateLoadedState(
          phones: response.phonesModels,
          companies: response.companiesModels,
          automatic: response.automatic,
          date: response.date,
          failed: response.failed,
          isUpdating: response.isUpdating,
        );
      },
    );
  }
}
