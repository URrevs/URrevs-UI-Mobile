import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/requests/reports_requests.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/report_state.dart';

class ReportNotifier extends StateNotifier<ReportState> {
  ReportNotifier({
    required this.socialItemId,
    required this.postContentType,
    required this.targetType,
    required this.parentPostId,
    required this.parentDirectInteractionId,
    required this.interactionType,
  })  : assert(!(interactionType != null && parentPostId == null)),
        assert(!(interactionType == InteractionType.reply &&
            parentDirectInteractionId == null)),
        super(ReportInitialState());

  String socialItemId;
  PostContentType postContentType;
  TargetType targetType;
  String? parentPostId;
  String? parentDirectInteractionId;
  InteractionType? interactionType;

  void reportPost(ReportSocialItemRequest request) async {
    state = ReportLoadingState();
    Either<Failure, void> response;
    switch (interactionType) {
      case InteractionType.comment:
        switch (targetType) {
          case TargetType.phone:
            response = await GetIt.I<Repository>()
                .reportPhoneReviewComment(parentPostId!, socialItemId, request);
            break;
          case TargetType.company:
            response = await GetIt.I<Repository>().reportCompanyReviewComment(
                parentPostId!, socialItemId, request);
            break;
        }
        break;
      case InteractionType.answer:
        switch (targetType) {
          case TargetType.phone:
            response = await GetIt.I<Repository>().reportPhoneQuestionAnswer(
                parentPostId!, socialItemId, request);
            break;
          case TargetType.company:
            response = await GetIt.I<Repository>().reportCompanyQuestionAnswer(
                parentPostId!, socialItemId, request);
            break;
        }
        break;
      case InteractionType.reply:
        switch (postContentType) {
          case PostContentType.review:
            switch (targetType) {
              case TargetType.phone:
                response = await GetIt.I<Repository>()
                    .reportPhoneReviewCommentReply(parentPostId!,
                        parentDirectInteractionId!, socialItemId, request);
                break;
              case TargetType.company:
                response = await GetIt.I<Repository>()
                    .reportCompanyReviewCommentReply(parentPostId!,
                        parentDirectInteractionId!, socialItemId, request);
                break;
            }
            break;
          case PostContentType.question:
            switch (targetType) {
              case TargetType.phone:
                response = await GetIt.I<Repository>()
                    .reportPhoneQuestionAnswerReply(parentPostId!,
                        parentDirectInteractionId!, socialItemId, request);
                break;
              case TargetType.company:
                response = await GetIt.I<Repository>()
                    .reportCompanyQuestionAnswerReply(parentPostId!,
                        parentDirectInteractionId!, socialItemId, request);
                break;
            }
            break;
        }
        break;
      case null:
        switch (postContentType) {
          case PostContentType.review:
            switch (targetType) {
              case TargetType.phone:
                response = await GetIt.I<Repository>()
                    .reportPhoneReview(socialItemId, request);
                break;
              case TargetType.company:
                response = await GetIt.I<Repository>()
                    .reportCompanyReview(socialItemId, request);
                break;
            }
            break;
          case PostContentType.question:
            switch (targetType) {
              case TargetType.phone:
                response = await GetIt.I<Repository>()
                    .reportPhoneQuestion(socialItemId, request);
                break;
              case TargetType.company:
                response = await GetIt.I<Repository>()
                    .reportCompanyQuestion(socialItemId, request);
                break;
            }
            break;
        }
        break;
    }
    response.fold(
      (failure) {
        return state = ReportErrorState(failure: failure);
      },
      (_) {
        state = ReportLoadedState();
      },
    );
  }
}
