import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/get_report_interaction_state.dart';

class GetReportInteractionNotifier
    extends StateNotifier<GetReportInteractionState> {
  GetReportInteractionNotifier({required this.report})
      : assert(!report.type.isPost),
        super(GetReportInteractionInitialState());

  Report report;

  void _getReportInteraction() async {
    state = GetReportInteractionLoadingState();
    Either<Failure, Interaction> response;
    switch (report.type) {
      case ReportType.phoneReview:
      case ReportType.companyReview:
      case ReportType.phoneQuestion:
      case ReportType.companyQuestion:
        return;
      case ReportType.phoneComment:
        response = await GetIt.I<Repository>()
            .showReportPhoneReviewComment(report.comment!);
        break;
      case ReportType.companyComment:
        response = await GetIt.I<Repository>()
            .showReportCompanyReviewComment(report.comment!);
        break;
      case ReportType.phoneAnswer:
        response = await GetIt.I<Repository>()
            .showReportPhoneQuestionAnswer(report.answer!);
        break;
      case ReportType.companyAnswer:
        response = await GetIt.I<Repository>()
            .showReportCompanyQuestionAnswer(report.answer!);
        break;
      case ReportType.phoneCommentReply:
        response = await GetIt.I<Repository>()
            .showReportPhoneReviewCommentReply(report.comment!, report.reply!);
        break;
      case ReportType.companyCommentReply:
        response = await GetIt.I<Repository>()
            .showReportCompanyReviewCommentReply(
                report.comment!, report.reply!);
        break;
      case ReportType.phoneAnswerReply:
        response = await GetIt.I<Repository>()
            .showReportPhoneQuestionAnswerReply(report.answer!, report.reply!);
        break;
      case ReportType.companyAnswerReply:
        response = await GetIt.I<Repository>()
            .showReportCompanyQuestionAnswerReply(
                report.answer!, report.reply!);
        break;
    }
    response.fold(
      (failure) => state = GetReportInteractionErrorState(failure: failure),
      (interaction) {
        state = GetReportInteractionLoadedState(interaction: interaction);
      },
    );
  }

  void toggleReportInteractionVisibility() async {
    final currentState = state;
    if (currentState is GetReportInteractionInitialState) {
      return _getReportInteraction();
    } else if (currentState is GetReportInteractionLoadedState) {
      state = GetReportInteractionHiddenState(
          interaction: currentState.interaction);
    } else if (currentState is GetReportInteractionHiddenState) {
      state = GetReportInteractionLoadedState(
          interaction: currentState.interaction);
    }
  }
}
