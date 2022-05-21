import 'package:dartz/dartz.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';

import '../../states/question_states/accept_answer_state.dart';

class AcceptAnswerNotifier extends StateNotifier<AcceptAnswerState> {
  AcceptAnswerNotifier({
    required this.ref,
    required this.questionId,
    required this.answerId,
    required this.targetType,
    required this.getInteractionsProviderParams,
  }) : super(AcceptAnswerInitialState());

  AutoDisposeStateNotifierProviderRef ref;
  String questionId;
  String answerId;
  TargetType targetType;
  GetInteractionsProviderParams? getInteractionsProviderParams;

  void setLoadingState(bool value) =>
      state = AcceptAnswerLoadingState(accepted: value);
  void setLoadedState(bool value) =>
      state = AcceptAnswerLoadedState(accepted: value);

  void markAnswerAsAccepted() async {
    setLoadingState(true);
    if (getInteractionsProviderParams != null) {
      ref
          .read(
              getInteractionsProvider(getInteractionsProviderParams!).notifier)
          .markAnswerAsAccepted(answerId);
    }
    Either<Failure, void> response;
    switch (targetType) {
      case TargetType.phone:
        response = await GetIt.I<Repository>()
            .markAnswerAsAcceptedForPhone(questionId, answerId);
        break;
      case TargetType.company:
        response = await GetIt.I<Repository>()
            .markAnswerAsAcceptedForCompany(questionId, answerId);
        break;
    }
    response.fold(
      (failure) {
        if (failure is IgnoredFailure) {
          setLoadedState(true);
          return;
        }
        state = AcceptAnswerErrorState(failure: failure);
        if (getInteractionsProviderParams != null) {
          ref
              .read(getInteractionsProvider(getInteractionsProviderParams!)
                  .notifier)
              .undoAcceptAnswer();
        }
      },
      (_) {
        setLoadedState(true);
      },
    );
  }

  void unmarkAnswerAsAccepted() async {
    setLoadingState(false);
    if (getInteractionsProviderParams != null) {
      ref
          .read(
              getInteractionsProvider(getInteractionsProviderParams!).notifier)
          .unmarkAnswerAsAcceptedAnswer();
    }
    Either<Failure, void> response;
    switch (targetType) {
      case TargetType.phone:
        response = await GetIt.I<Repository>()
            .unmarkAnswerAsAcceptedForPhone(questionId, answerId);
        break;
      case TargetType.company:
        response = await GetIt.I<Repository>()
            .unmarkAnswerAsAcceptedForCompany(questionId, answerId);
        break;
    }
    response.fold(
      (failure) {
        if (failure is IgnoredFailure) {
          setLoadedState(false);
          return;
        }
        state = AcceptAnswerErrorState(failure: failure);
        if (getInteractionsProviderParams != null) {
          ref
              .read(getInteractionsProvider(getInteractionsProviderParams!)
                  .notifier)
              .undoAcceptAnswer();
        }
      },
      (_) {
        setLoadedState(false);
      },
    );
  }

  void toggleAcceptedState() {
    final currentState = state;
    if (currentState is AcceptAnswerLoadedState && currentState.accepted) {
      unmarkAnswerAsAccepted();
    } else {
      markAnswerAsAccepted();
    }
  }
}
