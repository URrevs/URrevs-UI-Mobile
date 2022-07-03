import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/requests/reports_requests.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/block_user_state.dart';

class BlockUserNotifier extends StateNotifier<BlockUserState> {
  BlockUserNotifier({required this.report})
      : super(BlockUserInitialState(blocked: report.reporteeBlocked));

  Report report;

  void _block() async {
    state = BlockUserLoadingState(blocked: true);
    UpdateReportStateRequest request =
        UpdateReportStateRequest(blockUser: true);
    final response = await GetIt.I<Repository>()
        .blockUser(report.reporteeId, report.id, request);
    response.fold(
      (failure) {
        state = BlockUserErrorState(failure: failure);
        state = BlockUserLoadedState(blocked: false);
      },
      (_) {
        state = BlockUserLoadedState(blocked: true);
      },
    );
  }

  void _unblock() async {
    state = BlockUserLoadingState(blocked: false);
    UpdateReportStateRequest request =
        UpdateReportStateRequest(blockUser: false);
    final response = await GetIt.I<Repository>()
        .unblockUser(report.reporteeId, report.id, request);
    response.fold(
      (failure) {
        state = BlockUserErrorState(failure: failure);
        state = BlockUserLoadedState(blocked: true);
      },
      (_) {
        state = BlockUserLoadedState(blocked: false);
      },
    );
  }

  void toggleBlockState() {
    final currentState = state;
    if (currentState is BlockUserInitialState && currentState.blocked ||
        currentState is BlockUserLoadedState && currentState.blocked) {
      return _unblock();
    } else {
      return _block();
    }
  }
}
