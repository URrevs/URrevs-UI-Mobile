import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/update_targets_from_source_state.dart';

class UpdateTargetsFromSourceNotifier
    extends StateNotifier<UpdateTargetsFromSourceState> {
  UpdateTargetsFromSourceNotifier()
      : super(UpdateTargetsFromSourceInitialState());

  void updateTargetsFromSource() async {
    state = UpdateTargetsFromSourceLoadingState();
    final response = await GetIt.I<Repository>().updateTargetsFromSource();
    response.fold(
      (failure) => state = UpdateTargetsFromSourceErrorState(failure: failure),
      (_) {
        state = UpdateTargetsFromSourceLoadedState();
      },
    );
  }
}
