import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/requests/reports_requests.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/report_post_state.dart';

class ReportPostNotifier extends StateNotifier<ReportPostState> {
  ReportPostNotifier({
    required this.postId,
    required this.postContentType,
    required this.targetType,
  }) : super(ReportPostInitialState());

  String postId;
  PostContentType postContentType;
  TargetType targetType;

  void reportPost(ReportPostRequest request) async {
    state = ReportPostLoadingState();
    Either<Failure, void> response;
    switch (postContentType) {
      case PostContentType.review:
        switch (targetType) {
          case TargetType.phone:
            response =
                await GetIt.I<Repository>().reportPhoneReview(postId, request);
            break;
          case TargetType.company:
            response = await GetIt.I<Repository>()
                .reportCompanyReview(postId, request);
            break;
        }
        break;
      case PostContentType.question:
        switch (targetType) {
          case TargetType.phone:
            response = await GetIt.I<Repository>()
                .reportPhoneQuestion(postId, request);
            break;
          case TargetType.company:
            response = await GetIt.I<Repository>()
                .reportCompanyQuestion(postId, request);
            break;
        }
        break;
    }
    response.fold(
      (failure) {
        return state = ReportPostErrorState(failure: failure);
      },
      (_) {
        state = ReportPostLoadedState();
      },
    );
  }
}
