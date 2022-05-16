import 'package:dartz/dartz.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

import '../../states/reviews_states/get_interactions_state.dart';

class GetInteractionsNotifier extends StateNotifier<GetInteractionsState> {
  GetInteractionsNotifier({required String postId, required PostType postType})
      : _postId = postId,
        _postType = postType,
        super(GetInteractionsInitialState());

  int _round = 1;

  final String _postId;

  final PostType _postType;

  List<DirectInteraction> _currentInteractions = [];

  String? _lastAcceptedAnswerId;

  void undoAcceptAnswer() {
    final currentState = state;
    if (currentState is GetInteractionsLoadedState &&
        _postType.postContentType == PostContentType.question) {
      List<Answer> currentAnswers =
          currentState.infiniteScrollingItems.map((a) => a as Answer).toList();
      // remove new accepted answer
      if (currentAnswers.first.accepted) {
        Answer unAcceptedAnswer =
            currentAnswers.first.copyWith(accepted: false);
        currentAnswers.removeAt(0);
        currentAnswers.insert(0, unAcceptedAnswer);
      }
      // add last accepted answer
      if (_lastAcceptedAnswerId != null) {
        int index = currentAnswers
            .indexWhere((answer) => answer.id == _lastAcceptedAnswerId);
        Answer acceptedAnswer = currentAnswers[index].copyWith(accepted: true);
        currentAnswers.removeAt(index);
        currentAnswers.insert(0, acceptedAnswer);
      }
      // set state
      state = GetInteractionsLoadedState(
        infiniteScrollingItems: currentAnswers,
        roundsEnded: currentState.roundsEnded,
      );
      // SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {});
    }
    // clear last accepted answer
    _lastAcceptedAnswerId = null;
  }

  void unmarkAnswerAsAcceptedAnswer() {
    final currentState = state;
    if (currentState is GetInteractionsLoadedState &&
        _postType.postContentType == PostContentType.question) {
      List<Answer> currentAnswers =
          currentState.infiniteScrollingItems.map((a) => a as Answer).toList();
      if (currentAnswers.first.accepted) {
        _lastAcceptedAnswerId = currentAnswers.first.id;
        Answer unAcceptedAnswer =
            currentAnswers.first.copyWith(accepted: false);
        currentAnswers.removeAt(0);
        currentAnswers.insert(0, unAcceptedAnswer);
        state = GetInteractionsLoadedState(
          infiniteScrollingItems: currentAnswers,
          roundsEnded: currentState.roundsEnded,
        );
      }
    }
  }

  void markAnswerAsAccepted(String answerId) {
    final currentState = state;
    if (currentState is GetInteractionsLoadedState &&
        _postType.postContentType == PostContentType.question) {
      List<Answer> currentAnswers =
          currentState.infiniteScrollingItems.map((a) => a as Answer).toList();
      if (currentAnswers.first.accepted) {
        _lastAcceptedAnswerId = currentAnswers.first.id;
        Answer unAcceptedAnswer =
            currentAnswers.first.copyWith(accepted: false);
        currentAnswers.removeAt(0);
        currentAnswers.insert(0, unAcceptedAnswer);
      }
      int index = currentAnswers.indexWhere((answer) => answer.id == answerId);
      Answer acceptedAnswer = currentAnswers[index].copyWith(accepted: true);
      currentAnswers.removeAt(index);
      currentAnswers.insert(0, acceptedAnswer);
      state = GetInteractionsLoadedState(
        infiniteScrollingItems: currentAnswers,
        roundsEnded: currentState.roundsEnded,
      );
    }
  }

  void getInteractions() async {
    // get current items in the state
    List<DirectInteraction> currentinteractions = _currentInteractions;
    final currentState = state;
    if (currentState is GetInteractionsLoadedState) {
      currentinteractions = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetInteractionsLoadingState();
    late Either<Failure, List<DirectInteraction>> response;
    switch (_postType) {
      case PostType.phoneReview:
        response = await GetIt.I<Repository>()
            .getCommentsAndRepliesForPhoneReview(_postId, _round);
        break;
      case PostType.companyReview:
        response = await GetIt.I<Repository>()
            .getCommentsAndRepliesForCompanyReview(_postId, _round);
        break;
      case PostType.phoneQuestion:
        response = await GetIt.I<Repository>()
            .getAnswersAndRepliesForPhoneQuestion(_postId, _round);
        break;
      case PostType.companyQuestion:
        response = await GetIt.I<Repository>()
            .getAnswersAndRepliesForCompanyQuestion(_postId, _round);
        break;
    }
    response.fold(
      // deal with failure
      (failure) => state = GetInteractionsErrorState(failure: failure),
      (interactions) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = interactions.isEmpty;
        List<DirectInteraction> newInteractions = [
          ...currentinteractions,
          ...interactions
        ];
        _currentInteractions = [...newInteractions];
        state = GetInteractionsLoadedState(
          infiniteScrollingItems: newInteractions,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
      },
    );
  }

  void addInteractionToState(DirectInteraction interaction) {
    var currentState = state;
    if (currentState is GetInteractionsLoadedState) {
      // preserving accepted answer at first
      List<DirectInteraction> newInteractions = [
        ...currentState.infiniteScrollingItems
      ];
      if (_currentInteractions.isNotEmpty &&
          newInteractions.first is Answer &&
          (newInteractions.first as Answer).accepted) {
        newInteractions.insert(1, interaction);
      } else {
        newInteractions.insert(0, interaction);
      }
      state = GetInteractionsLoadedState(
        infiniteScrollingItems: [...newInteractions],
        roundsEnded: currentState.roundsEnded,
      );
      currentState = state as GetInteractionsLoadedState;
    }
  }

  void addReplyToCommentInState(String parentId, ReplyModel reply) {
    final currentState = state;
    if (currentState is GetInteractionsLoadedState) {
      List<DirectInteraction> currentInteractions = [
        ...currentState.infiniteScrollingItems
      ];
      int index = currentInteractions.indexWhere((i) => i.id == parentId);
      currentInteractions[index].replies.add(reply);
      state = GetInteractionsLoadedState(
        infiniteScrollingItems: [...currentInteractions],
        roundsEnded: currentState.roundsEnded,
      );
    }
  }
}
