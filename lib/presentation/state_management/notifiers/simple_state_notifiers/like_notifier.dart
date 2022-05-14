import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/like_state.dart';

import '../../../../domain/failure.dart';

class LikeNotifier extends StateNotifier<LikeState> {
  LikeNotifier({
    required String socialItemId,
    required String? replyParentId,
    required PostType postType,
    required InteractionType? interactionType,
  })  : _socialItemId = socialItemId,
        _replyParentId = replyParentId,
        _postType = postType,
        _interactionType = interactionType,
        super(LikeInitialState());

  final String _socialItemId;
  final String? _replyParentId;
  final PostType _postType;
  final InteractionType? _interactionType;

  void setLoadedState(bool value) => state = LikeLoadedState(liked: value);
  void setLoadingState(bool value) => state = LikeLoadingState(liked: value);

  void _like() async {
    setLoadingState(true);
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
            // TODO: Handle this case.
            break;
        }
        break;
      case InteractionType.answer:
        // TODO: Handle this case.
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
            // TODO: Handle this case.
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
      },
      (_) => setLoadedState(true),
    );
  }

  void _unlike() async {
    setLoadingState(false);
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
            // TODO: Handle this case.
            break;
        }
        break;
      case InteractionType.answer:
        // TODO: Handle this case.
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
            // TODO: Handle this case.
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
