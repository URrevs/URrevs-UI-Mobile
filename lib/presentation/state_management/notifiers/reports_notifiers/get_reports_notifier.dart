import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/get_reports_state.dart';

class GetReportsNotifier extends StateNotifier<GetReportsState> {
  GetReportsNotifier({required this.reportStatus})
      : super(GetReportsInitialState());

  ReportStatus reportStatus;

  int _round = 1;

  Future<void> getReports() async {
    // get current items in the state
    List<Report> currentReports = [];
    final currentState = state;
    if (currentState is GetReportsLoadedState) {
      currentReports = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetReportsLoadingState();
    Either<Failure, List<Report>> response;
    switch (reportStatus) {
      case ReportStatus.open:
        response = await GetIt.I<Repository>().getOpenReports(_round);
        break;
      case ReportStatus.closed:
        response = await GetIt.I<Repository>().getClosedReports(_round);
        break;
    }
    response.fold(
      // deal with failure
      (failure) => state = GetReportsErrorState(failure: failure),
      (reports) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = reports.isEmpty;
        List<Report> newReports = [...currentReports, ...reports];
        state = GetReportsLoadedState(
          infiniteScrollingItems: newReports,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
      },
    );
  }
}
