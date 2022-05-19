import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/question_states/get_post_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/like_state.dart';

import '../../states/reviews_states/get_posts_list_state.dart';

class GetPostsListNotifier extends StateNotifier<GetPostsListState> {
  GetPostsListNotifier({required this.ref}) : super(GetPostsListInitialState());

  final AutoDisposeStateNotifierProviderRef ref;

  int _round = 1;

  Future<Either<Failure, List<Post>>> _getUserPostsResponse({
    required String? userId,
    required TargetType targetType,
    required PostContentType postContentType,
  }) async {
    late Either<Failure, List<Post>> response;
    if (postContentType == PostContentType.question) {
      if (targetType == TargetType.phone) {
        if (userId == null) {
          response = await GetIt.I<Repository>().getMyPhoneQuestions(_round);
        } else {
          response = await GetIt.I<Repository>()
              .getPhoneQuestionsOfAnotherUser(userId, _round);
        }
      } else {
        if (userId == null) {
          response = await GetIt.I<Repository>().getMyCompanyQuestions(_round);
        } else {
          response = await GetIt.I<Repository>()
              .getCompanyQuestionsOfAnotherUser(userId, _round);
        }
      }
    } else if (postContentType == PostContentType.review) {
      if (targetType == TargetType.phone) {
        if (userId == null) {
          response = await GetIt.I<Repository>().getMyPhoneReviews(_round);
        } else {
          response = await GetIt.I<Repository>()
              .getPhoneReviewsOfAnotherUser(userId, _round);
        }
      } else {
        if (userId == null) {
          response = await GetIt.I<Repository>().getMyCompanyReviews(_round);
        } else {
          response = await GetIt.I<Repository>()
              .getCompanyReviewsOfAnotherUser(userId, _round);
        }
      }
    }
    return response;
  }

  Future<Either<Failure, List<Post>>> _getTargetPostsResponse({
    required String targetId,
    required TargetType targetType,
    required PostContentType postContentType,
  }) async {
    late Either<Failure, List<Post>> response;
    if (postContentType == PostContentType.question) {
      if (targetType == TargetType.phone) {
        response = await GetIt.I<Repository>()
            .getQuestionsOnCertainPhone(targetId, _round);
      } else if (targetType == TargetType.company) {
        response = await GetIt.I<Repository>()
            .getQuestionsOnCertainCompany(targetId, _round);
      }
    } else if (postContentType == PostContentType.review) {
      if (targetType == TargetType.phone) {
        response = await GetIt.I<Repository>()
            .getReviewsOnCertainPhone(targetId, _round);
      } else if (targetType == TargetType.company) {
        response = await GetIt.I<Repository>()
            .getReviewsOnCertainCompany(targetId, _round);
      }
    }
    return response;
  }

  void getPostsList({
    required PostsListType postsListType,
    required TargetType targetType,
    required PostContentType postContentType,
    required String? targetId,
    required String? userId,
  }) async {
    assert(!(postsListType == PostsListType.target && targetId == null));
    assert(!(postsListType == PostsListType.target && userId != null));
    // do not load new posts if not in initial or loaded states
    print(state);
    if (state is GetPostsListLoadingState) return;

    // get current items in the state
    List<Post> currentPosts = [];
    final currentState = state;
    if (currentState is GetPostsListLoadedState) {
      currentPosts = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetPostsListLoadingState();
    late Either<Failure, List<Post>> response;
    switch (postsListType) {
      case PostsListType.user:
        response = await _getUserPostsResponse(
          userId: userId,
          targetType: targetType,
          postContentType: postContentType,
        );
        break;
      case PostsListType.target:
        response = await _getTargetPostsResponse(
          targetId: targetId!,
          targetType: targetType,
          postContentType: postContentType,
        );
        break;
    }
    response.fold(
      // deal with failure
      (failure) => state = GetPostsListErrorState(failure: failure),
      (posts) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = posts.isEmpty;
        List<Post> newPosts = [...currentPosts, ...posts];
        state = GetPostsListLoadedState(
          infiniteScrollingItems: newPosts,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
        // add listeners to like providers of these posts
        for (Post post in posts) {
          final params = LikeProviderParams(
            socialItemId: post.id,
            replyParentId: null,
            postType: post.postType,
            interactionType: null,
            getInteractionsProviderParams: null,
          );
          ref.listen(likeProvider(params), (previous, next) {
            final currentState = state;
            if (currentState is GetPostsListLoadedState &&
                next is LikeLoadedState) {
              List<Post> posts = [...currentState.infiniteScrollingItems];
              int index = posts.indexWhere((p) => p.id == post.id);
              Post changedPost = posts[index];
              if (changedPost is PhoneReview) {
                changedPost = changedPost.copyWith(liked: next.liked);
              } else if (changedPost is CompanyReview) {
                changedPost = changedPost.copyWith(liked: next.liked);
              } else {
                changedPost =
                    (changedPost as Question).copyWith(upvoted: next.liked);
              }
              posts.removeAt(index);
              posts.insert(index, changedPost);
              state = GetPostsListLoadedState(
                infiniteScrollingItems: posts,
                roundsEnded: currentState.roundsEnded,
              );
            }
          });
        }
      },
    );
  }
}
