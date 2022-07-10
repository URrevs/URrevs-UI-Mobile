import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/delete_data_state.dart';

class DeleteDataNotifier extends StateNotifier<DeleteDataState> {
  DeleteDataNotifier({required bool requestedInitialState})
      : super(DeleteDataInitialState(requested: requestedInitialState));

  void _deleteData() async {
    state = DeleteDataLoadingState(requested: true);
    final response = await GetIt.I<Repository>().deleteData();
    response.fold(
      (failure) {
        state = DeleteDataErrorState(failure: failure);
        state = DeleteDataLoadedState(requested: false);
      },
      (_) {
        state = DeleteDataLoadedState(requested: true);
      },
    );
  }

  void _undoDeleteData() async {
    state = DeleteDataLoadingState(requested: false);
    final response = await GetIt.I<Repository>().undoDeleteData();
    response.fold(
      (failure) {
        state = DeleteDataErrorState(failure: failure);
        state = DeleteDataLoadedState(requested: true);
      },
      (_) {
        state = DeleteDataLoadedState(requested: false);
      },
    );
  }

  void toggle() {
    final currentState = state;
    if (currentState is DeleteDataLoadedState && currentState.requested) {
      _undoDeleteData();
    } else {
      _deleteData();
    }
  }
}
