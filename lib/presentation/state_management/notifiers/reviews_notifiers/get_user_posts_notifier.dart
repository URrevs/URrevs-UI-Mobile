import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

import '../../states/reviews_states/get_user_posts_state.dart';

class GetPostsListNotifier extends StateNotifier<GetPostsListState> {
  GetPostsListNotifier() : super(GetPostsListInitialState());

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
        // response = await GetIt.I<Repository>()
        //     .getPhoneQuestionsOfAnotherUser(_userId!, _round);
      } else if (targetType == TargetType.company) {
        // response = await GetIt.I<Repository>()
        //     .getCompanyQuestionsOfAnotherUser(_userId!, _round);
      }
    } else if (postContentType == PostContentType.review) {
      if (targetType == TargetType.phone) {
        response = await GetIt.I<Repository>()
            .getReviewsOnCertainPhone(targetId, _round);
      } else if (targetType == TargetType.company) {
        // response = await GetIt.I<Repository>().getMyCompanyReviews(_round);
      }
    }
    return response;
  }

  void getUserPosts({
    required PostsListType postsListType,
    required TargetType targetType,
    required PostContentType postContentType,
    required String? targetId,
    required String? userId,
  }) async {
    assert(!(postsListType == PostsListType.target && targetId == null));
    // get current items in the state
    List<Post> currentphoneReviews = [];
    final currentState = state;
    if (currentState is GetPostsListLoadedState) {
      currentphoneReviews = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetPostsListLoadingState();
    late Either<Failure, List<Post>> response;
    if (postsListType == PostsListType.user) {
      response = await _getUserPostsResponse(
        userId: userId,
        targetType: targetType,
        postContentType: postContentType,
      );
    } else {
      response = await _getTargetPostsResponse(
        targetId: targetId!,
        targetType: targetType,
        postContentType: postContentType,
      );
    }
    response.fold(
      // deal with failure
      (failure) => state = GetPostsListErrorState(failure: failure),
      (phoneReviews) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = phoneReviews.isEmpty;
        List<Post> newphoneReviews = [...currentphoneReviews, ...phoneReviews];
        state = GetPostsListLoadedState(
          infiniteScrollingItems: newphoneReviews,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
      },
    );
  }

  void getPostsOnCertainTarget({
    required String targetId,
    required TargetType targetType,
    required PostContentType postContentType,
  }) async {}
}
