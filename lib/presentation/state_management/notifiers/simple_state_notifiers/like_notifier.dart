import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/like_state.dart';

import '../../../../domain/failure.dart';

class LikeNotifier extends StateNotifier<LikeState> {
  LikeNotifier({
    required String socialItemId,
    required String? replyParentId,
    required PostType postType,
    required InteractionType? interactionType,
    required this.getInteractionsProviderParams,
    required this.ref,
  })  : _socialItemId = socialItemId,
        _replyParentId = replyParentId,
        _postType = postType,
        _interactionType = interactionType,
        super(LikeInitialState());

  final String _socialItemId;
  final String? _replyParentId;
  final PostType _postType;
  final InteractionType? _interactionType;
  final AutoDisposeStateNotifierProviderRef ref;
  final GetInteractionsProviderParams? getInteractionsProviderParams;

  late final PostProviderParams _postProviderParams = PostProviderParams(
    postId: _socialItemId,
    postType: _postType,
    post: null,
  );

  late final DirectInteractionProviderParams? _directInteractionProviderParams =
      _interactionType != null
          ? DirectInteractionProviderParams(
              interactionId: _socialItemId,
              interactionType: _interactionType!,
              interaction: DirectInteraction(id: 'dummy', replies: []),
            )
          : null;

  late final ReplyProviderParams _replyProviderParams = ReplyProviderParams(
    replyId: _socialItemId,
    reply: ReplyModel.dummyInstance,
  );

  void setLoadedState(bool value) => state = LikeLoadedState(liked: value);
  void setLoadingState(bool value) => state = LikeLoadingState(liked: value);

  void _incrementLikes() {
    if (_interactionType == null) {
      ref.read(postProvider(_postProviderParams).notifier).incrementLikes();
    } else if (_interactionType != InteractionType.reply) {
      ref
          .read(directInteractionsProvider(_directInteractionProviderParams!)
              .notifier)
          .incrementLikes();
    } else {
      ref.read(replyProvider(_replyProviderParams).notifier).incrementLikes();
    }
  }

  void _decrementLikes() {
    if (_interactionType == null) {
      ref.read(postProvider(_postProviderParams).notifier).decrementLikes();
    } else if (_interactionType != InteractionType.reply) {
      ref
          .read(directInteractionsProvider(_directInteractionProviderParams!)
              .notifier)
          .decrementLikes();
    } else {
      ref.read(replyProvider(_replyProviderParams).notifier).incrementLikes();
    }
  }

  void _like() async {
    setLoadingState(true);
    _incrementLikes();
    late Either<Failure, void> response;
    switch (_interactionType) {
      case InteractionType.comment:
        switch (_postType) {
          case PostType.phoneReview:
            response = await GetIt.I<Repository>()
                .likePhoneReviewComment(_socialItemId);
            break;
          case PostType.companyReview:
            response = await GetIt.I<Repository>()
                .likeCompanyReviewComment(_socialItemId);
            break;
          case PostType.phoneQuestion:
          case PostType.companyQuestion:
            throw UnimplementedError();
        }
        break;
      case InteractionType.answer:
        switch (_postType) {
          case PostType.phoneReview:
          case PostType.companyReview:
            throw UnimplementedError();
          case PostType.phoneQuestion:
            response = await GetIt.I<Repository>()
                .upvotePhoneQuestionAnswer(_socialItemId);
            break;
          case PostType.companyQuestion:
            response = await GetIt.I<Repository>()
                .upvoteCompanyQuestionAnswer(_socialItemId);
            break;
        }
        break;
      case InteractionType.reply:
        switch (_postType) {
          case PostType.phoneReview:
            response = await GetIt.I<Repository>()
                .likePhoneReviewReply(_replyParentId!, _socialItemId);
            break;
          case PostType.companyReview:
            response = await GetIt.I<Repository>()
                .likeCompanyReviewReply(_replyParentId!, _socialItemId);
            break;
          case PostType.phoneQuestion:
            response = await GetIt.I<Repository>()
                .likePhoneQuestionReply(_replyParentId!, _socialItemId);
            break;
          case PostType.companyQuestion:
            response = await GetIt.I<Repository>()
                .likeCompanyQuestionReply(_replyParentId!, _socialItemId);
            break;
        }
        break;
      case null:
        switch (_postType) {
          case PostType.phoneReview:
            response =
                await GetIt.I<Repository>().likePhoneReview(_socialItemId);
            break;
          case PostType.companyReview:
            response =
                await GetIt.I<Repository>().likeCompanyReview(_socialItemId);
            break;
          case PostType.phoneQuestion:
            response =
                await GetIt.I<Repository>().upvotePhoneQuestion(_socialItemId);
            break;
          case PostType.companyQuestion:
            response = await GetIt.I<Repository>()
                .upvoteCompanyQuestion(_socialItemId);
            break;
        }
    }
    response.fold(
      (failure) {
        state = LikeErrorState(failure: failure);
        setLoadedState(false);
        _decrementLikes();
      },
      (_) => setLoadedState(true),
    );
  }

  void _unlike() async {
    setLoadingState(false);
    _decrementLikes();
    late Either<Failure, void> response;
    switch (_interactionType) {
      case InteractionType.comment:
        switch (_postType) {
          case PostType.phoneReview:
            response = await GetIt.I<Repository>()
                .unlikePhoneReviewComment(_socialItemId);
            break;
          case PostType.companyReview:
            response = await GetIt.I<Repository>()
                .unlikeCompanyReviewComment(_socialItemId);
            break;
          case PostType.phoneQuestion:
          case PostType.companyQuestion:
            throw UnimplementedError();
        }
        break;
      case InteractionType.answer:
        switch (_postType) {
          case PostType.phoneReview:
          case PostType.companyReview:
            throw UnimplementedError();
          case PostType.phoneQuestion:
            response = await GetIt.I<Repository>()
                .downvotePhoneQuestionAnswer(_socialItemId);
            break;
          case PostType.companyQuestion:
            response = await GetIt.I<Repository>()
                .downvoteCompanyQuestionAnswer(_socialItemId);
            break;
        }
        break;
      case InteractionType.reply:
        switch (_postType) {
          case PostType.phoneReview:
            response = await GetIt.I<Repository>()
                .unlikePhoneReviewReply(_replyParentId!, _socialItemId);
            break;
          case PostType.companyReview:
            response = await GetIt.I<Repository>()
                .unlikeCompanyReviewReply(_replyParentId!, _socialItemId);
            break;
          case PostType.phoneQuestion:
            response = await GetIt.I<Repository>()
                .unlikePhoneQuestionReply(_replyParentId!, _socialItemId);
            break;
          case PostType.companyQuestion:
            response = await GetIt.I<Repository>()
                .unlikeCompanyQuestionReply(_replyParentId!, _socialItemId);
            break;
        }
        break;
      case null:
        switch (_postType) {
          case PostType.phoneReview:
            response =
                await GetIt.I<Repository>().unlikePhoneReview(_socialItemId);
            break;
          case PostType.companyReview:
            response =
                await GetIt.I<Repository>().unlikeCompanyReview(_socialItemId);
            break;
          case PostType.phoneQuestion:
            response = await GetIt.I<Repository>()
                .downvotePhoneQuestion(_socialItemId);
            break;
          case PostType.companyQuestion:
            response = await GetIt.I<Repository>()
                .downvoteCompanyQuestion(_socialItemId);
            break;
        }
    }
    response.fold(
      (failure) {
        state = LikeErrorState(failure: failure);
        setLoadedState(true);
        _incrementLikes();
      },
      (_) => setLoadedState(false),
    );
  }

  void toggleLikeState() {
    final currentState = state;
    if (currentState is LikeLoadedState && currentState.liked) {
      _unlike();
    } else {
      _like();
    }
  }
}
