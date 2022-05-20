import 'package:dartz/dartz.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/like_state.dart';

import '../../states/reviews_states/get_interactions_state.dart';

class GetInteractionsNotifier extends StateNotifier<GetInteractionsState> {
  GetInteractionsNotifier({
    required String postId,
    required PostType postType,
    required this.ref,
  })  : _postId = postId,
        _postType = postType,
        super(GetInteractionsInitialState());

  int _round = 1;

  final String _postId;

  final PostType _postType;

  final AutoDisposeStateNotifierProviderRef ref;

  List<DirectInteraction> _currentInteractions = [];

  String? _lastAcceptedAnswerId;

  void toggleLikedState({
    required String interactionId,
    required InteractionType interactionType,
  }) {
    final currentState = state;
    if (currentState is GetInteractionsLoadedState) {
      if (interactionType != InteractionType.reply) {
      } else if (interactionType == InteractionType.reply) {}
    }
  }

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
        // add like listeners to interactions
        for (DirectInteraction interaction in interactions) {
          final params = LikeProviderParams(
            socialItemId: interaction.id,
            replyParentId: null,
            postType: _postType,
            interactionType: interaction.interactionType,
            getInteractionsProviderParams: null,
          );
          ref.listen(likeProvider(params), (previous, next) {
            final currentState = state;
            if (currentState is GetInteractionsLoadedState &&
                next is LikeLoadedState) {
              List<DirectInteraction> updatedInteractions = [
                ...currentState.infiniteScrollingItems
              ];
              int index =
                  updatedInteractions.indexWhere((i) => i.id == interaction.id);
              DirectInteraction changedInteraction = updatedInteractions[index];
              if (changedInteraction is Comment) {
                changedInteraction =
                    changedInteraction.copyWith(liked: next.liked);
              } else if (changedInteraction is Answer) {
                changedInteraction =
                    changedInteraction.copyWith(upvoted: next.liked);
              }
              updatedInteractions.removeAt(index);
              updatedInteractions.insert(index, changedInteraction);
              state = GetInteractionsLoadedState(
                infiniteScrollingItems: updatedInteractions,
                roundsEnded: currentState.roundsEnded,
              );
            }
          });
          for (ReplyModel reply in interaction.replies) {
            final replyParams = LikeProviderParams(
              socialItemId: reply.id,
              replyParentId: interaction.id,
              postType: _postType,
              interactionType: InteractionType.reply,
              getInteractionsProviderParams: null,
            );
            ref.listen(likeProvider(replyParams), (previous, next) {
              final currentState = state;
              if (currentState is GetInteractionsLoadedState &&
                  next is LikeLoadedState) {
                List<DirectInteraction> updatedInteractions = [
                  ...currentState.infiniteScrollingItems
                ];
                int interactionIndex = updatedInteractions
                    .indexWhere((i) => i.replies.any((r) => r.id == reply.id));
                List<ReplyModel> updatedReplies = [
                  ...updatedInteractions[interactionIndex].replies
                ];
                int replyIndex =
                    updatedReplies.indexWhere((r) => r.id == reply.id);
                ReplyModel changedReply =
                    updatedReplies[replyIndex].copyWith(liked: next.liked);
                updatedReplies.removeAt(replyIndex);
                updatedReplies.insert(replyIndex, changedReply);
                DirectInteraction changedInteraction =
                    updatedInteractions[interactionIndex]
                        .copyWith(replies: updatedReplies);
                updatedInteractions.removeAt(interactionIndex);
                updatedInteractions.insert(
                    interactionIndex, changedInteraction);

                state = GetInteractionsLoadedState(
                  infiniteScrollingItems: updatedInteractions,
                  roundsEnded: currentState.roundsEnded,
                );
              }
            });
          }
        }
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
