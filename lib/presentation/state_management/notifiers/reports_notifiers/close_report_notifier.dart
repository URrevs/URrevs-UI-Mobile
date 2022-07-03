import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/close_report_state.dart';

class CloseReportNotifier extends StateNotifier<CloseReportState> {
  CloseReportNotifier({required this.report})
      : super(CloseReportInitialState());

  Report report;

  void closeReport() async {
    state = CloseReportLoadingState();
    final response = await GetIt.I<Repository>().closeReport(report.id);
    response.fold(
      (failure) => state = CloseReportErrorState(failure: failure),
      (_) {
        state = CloseReportLoadedState();
      },
    );
  }
}
