import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/domain/repository_returned_models.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/get_report_context_state.dart';

class GetReportContextNotifier extends StateNotifier<GetReportContextState> {
  GetReportContextNotifier({required this.report})
      : assert(!report.type.isPost),
        super(GetReportContextInitialState());

  Report report;

  void getReportContext() async {
    state = GetReportContextLoadingState();
    Either<Failure, ShowReportContextReturnedVals> response;
    switch (report.type) {
      case ReportType.phoneReview:
      case ReportType.companyReview:
      case ReportType.phoneQuestion:
      case ReportType.companyQuestion:
        return;
      case ReportType.phoneComment:
      case ReportType.phoneCommentReply:
        response = await GetIt.I<Repository>()
            .showReportPhoneReviewCommentContext(
                report.phoneReview!, report.comment!);
        break;
      case ReportType.companyComment:
      case ReportType.companyCommentReply:
        response = await GetIt.I<Repository>()
            .showReportCompanyReviewCommentContext(
                report.companyReview!, report.comment!);
        break;
      case ReportType.phoneAnswer:
      case ReportType.phoneAnswerReply:
        response = await GetIt.I<Repository>()
            .showReportPhoneQuestionAnswerContext(
                report.question!, report.answer!);
        break;
      case ReportType.companyAnswer:
      case ReportType.companyAnswerReply:
        response = await GetIt.I<Repository>()
            .showReportCompanyQuestionAnswerContext(
                report.question!, report.answer!);
        break;
    }
    response.fold(
      (failure) => state = GetReportContextErrorState(failure: failure),
      (returnedVals) {
        state = GetReportContextLoadedState(
          post: returnedVals.post,
          directInteraction: returnedVals.directInteraction,
        );
      },
    );
  }
}
