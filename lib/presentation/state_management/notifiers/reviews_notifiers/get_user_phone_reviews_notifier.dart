import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

import '../../states/reviews_states/get_user_phone_reviews_state.dart';

class GetUserPostsNotifier extends StateNotifier<GetUserPhoneReviewsState> {
  GetUserPostsNotifier({
    required String? userId,
    required PostContentType postContentType,
  })  : _userId = userId,
        _postContentType = postContentType,
        super(GetUserPhoneReviewsInitialState());

  int _round = 1;

  final String? _userId;
  final PostContentType _postContentType;

  void getUserPosts(TargetType targetType) async {
    // get current items in the state
    List<Post> currentphoneReviews = [];
    final currentState = state;
    if (currentState is GetUserPhoneReviewsLoadedState) {
      currentphoneReviews = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetUserPhoneReviewsLoadingState();
    late Either<Failure, List<Post>> response;
    if (_postContentType == PostContentType.question) {
      if (targetType == TargetType.phone) {
        if (_userId == null) {
          response = await GetIt.I<Repository>().getMyPhoneQuestions(_round);
        } else {
          response = await GetIt.I<Repository>()
              .getPhoneQuestionsOfAnotherUser(_userId!, _round);
        }
      } else {
        if (_userId == null) {
          response = await GetIt.I<Repository>().getMyCompanyQuestions(_round);
        } else {
          response = await GetIt.I<Repository>()
              .getCompanyQuestionsOfAnotherUser(_userId!, _round);
        }
      }
    } else if (_postContentType == PostContentType.review) {
      if (targetType == TargetType.phone) {
        if (_userId == null) {
          response = await GetIt.I<Repository>().getMyPhoneReviews(_round);
        } else {
          response = await GetIt.I<Repository>()
              .getPhoneReviewsOfAnotherUser(_userId!, _round);
        }
      } else {
        if (_userId == null) {
          response = await GetIt.I<Repository>().getMyCompanyReviews(_round);
        } else {
          response = await GetIt.I<Repository>()
              .getCompanyReviewsOfAnotherUser(_userId!, _round);
        }
      }
    }
    response.fold(
      // deal with failure
      (failure) => state = GetUserPhoneReviewsErrorState(failure: failure),
      (phoneReviews) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = phoneReviews.isEmpty;
        List<Post> newphoneReviews = [
          ...currentphoneReviews,
          ...phoneReviews
        ];
        state = GetUserPhoneReviewsLoadedState(
          infiniteScrollingItems: newphoneReviews,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
      },
    );
  }
}
