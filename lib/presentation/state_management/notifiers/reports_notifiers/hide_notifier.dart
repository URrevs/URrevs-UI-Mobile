import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/requests/reports_requests.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/hide_state.dart';

class HideNotifier extends StateNotifier<HideState> {
  HideNotifier({
    required this.report,
  }) : super(HideInitialState(hidden: report.contentHidden));

  Report report;

  void _hide() async {
    state = HideLoadingState(hidden: true);
    UpdateReportStateRequest requset =
        UpdateReportStateRequest(hideContent: true);
    Either<Failure, void> response;
    switch (report.type) {
      case ReportType.phoneReview:
        response = await GetIt.I<Repository>()
            .hidePhoneReview(report.phoneReview!, report.id, requset);
        break;
      case ReportType.companyReview:
        response = await GetIt.I<Repository>()
            .hideCompanyReview(report.companyReview!, report.id, requset);
        break;
      case ReportType.phoneQuestion:
        response = await GetIt.I<Repository>()
            .hidePhoneQuestion(report.question!, report.id, requset);
        break;
      case ReportType.companyQuestion:
        response = await GetIt.I<Repository>()
            .hideCompanyQuestion(report.question!, report.id, requset);
        break;
      case ReportType.phoneComment:
        response = await GetIt.I<Repository>()
            .hidePhoneReviewComment(report.comment!, report.id, requset);
        break;
      case ReportType.companyComment:
        response = await GetIt.I<Repository>()
            .hideCompanyReviewComment(report.comment!, report.id, requset);
        break;
      case ReportType.phoneAnswer:
        response = await GetIt.I<Repository>()
            .hidePhoneQuestionAnswer(report.answer!, report.id, requset);
        break;
      case ReportType.companyAnswer:
        response = await GetIt.I<Repository>()
            .hideCompanyQuestionAnswer(report.answer!, report.id, requset);
        break;
      case ReportType.phoneCommentReply:
        response = await GetIt.I<Repository>().hidePhoneReviewReply(
            report.comment!, report.reply!, report.id, requset);
        break;
      case ReportType.companyCommentReply:
        response = await GetIt.I<Repository>().hideCompanyReviewReply(
            report.comment!, report.reply!, report.id, requset);
        break;
      case ReportType.phoneAnswerReply:
        response = await GetIt.I<Repository>().hidePhoneQuestionReply(
            report.answer!, report.reply!, report.id, requset);
        break;
      case ReportType.companyAnswerReply:
        response = await GetIt.I<Repository>().hideCompanyQuestionReply(
            report.answer!, report.reply!, report.id, requset);
        break;
    }
    response.fold(
      (failure) {
        state = HideErrorState(failure: failure);
        state = HideLoadedState(hidden: false);
      },
      (_) {
        state = HideLoadedState(hidden: true);
      },
    );
  }

  void _unhide() async {
    state = HideLoadingState(hidden: false);
    UpdateReportStateRequest requset =
        UpdateReportStateRequest(hideContent: false);
    Either<Failure, void> response;
    switch (report.type) {
      case ReportType.phoneReview:
        response = await GetIt.I<Repository>()
            .unhidePhoneReview(report.phoneReview!, report.id, requset);
        break;
      case ReportType.companyReview:
        response = await GetIt.I<Repository>()
            .unhideCompanyReview(report.companyReview!, report.id, requset);
        break;
      case ReportType.phoneQuestion:
        response = await GetIt.I<Repository>()
            .unhidePhoneQuestion(report.question!, report.id, requset);
        break;
      case ReportType.companyQuestion:
        response = await GetIt.I<Repository>()
            .unhideCompanyQuestion(report.question!, report.id, requset);
        break;
      case ReportType.phoneComment:
        response = await GetIt.I<Repository>()
            .unhidePhoneReviewComment(report.comment!, report.id, requset);
        break;
      case ReportType.companyComment:
        response = await GetIt.I<Repository>()
            .unhideCompanyReviewComment(report.comment!, report.id, requset);
        break;
      case ReportType.phoneAnswer:
        response = await GetIt.I<Repository>()
            .unhidePhoneQuestionAnswer(report.answer!, report.id, requset);
        break;
      case ReportType.companyAnswer:
        response = await GetIt.I<Repository>()
            .unhideCompanyQuestionAnswer(report.answer!, report.id, requset);
        break;
      case ReportType.phoneCommentReply:
        response = await GetIt.I<Repository>().unhidePhoneReviewReply(
            report.comment!, report.reply!, report.id, requset);
        break;
      case ReportType.companyCommentReply:
        response = await GetIt.I<Repository>().unhideCompanyReviewReply(
            report.comment!, report.reply!, report.id, requset);
        break;
      case ReportType.phoneAnswerReply:
        response = await GetIt.I<Repository>().unhidePhoneQuestionReply(
            report.answer!, report.reply!, report.id, requset);
        break;
      case ReportType.companyAnswerReply:
        response = await GetIt.I<Repository>().unhideCompanyQuestionReply(
            report.answer!, report.reply!, report.id, requset);
        break;
    }
    response.fold(
      (failure) {
        state = HideErrorState(failure: failure);
        state = HideLoadedState(hidden: true);
      },
      (_) {
        state = HideLoadedState(hidden: false);
      },
    );
  }

  void toggle() {
    final currentState = state;
    if (currentState is HideInitialState && currentState.hidden ||
        currentState is HideLoadedState && currentState.hidden) {
      _unhide();
    } else {
      _hide();
    }
  }
}
