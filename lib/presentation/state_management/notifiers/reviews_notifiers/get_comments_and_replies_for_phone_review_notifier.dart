import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

import '../../states/reviews_states/get_comments_and_replies_for_phone_review_state.dart';

class GetCommentsAndRepliesForPhoneReviewNotifier
    extends StateNotifier<GetCommentsAndRepliesForPhoneReviewState> {
  GetCommentsAndRepliesForPhoneReviewNotifier(
      {required String postId, required PostType postType})
      : _postId = postId,
        _postType = postType,
        super(GetCommentsAndRepliesForPhoneReviewInitialState());

  int _round = 1;

  String _postId;

  PostType _postType;

  List<Comment> _currentComments = [];

  void getCommentsAndRepliesForPhoneReview() async {
    // get current items in the state
    List<Comment> currentComments = _currentComments;
    final currentState = state;
    if (currentState is GetCommentsAndRepliesForPhoneReviewLoadedState) {
      currentComments = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetCommentsAndRepliesForPhoneReviewLoadingState();
    final response = await GetIt.I<Repository>()
        .getCommentsAndRepliesForPhoneReview(_postId, _round);
    response.fold(
      // deal with failure
      (failure) => state =
          GetCommentsAndRepliesForPhoneReviewErrorState(failure: failure),
      (comments) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = comments.isEmpty;
        List<Comment> newComments = [...currentComments, ...comments];
        _currentComments = [...newComments];
        state = GetCommentsAndRepliesForPhoneReviewLoadedState(
          infiniteScrollingItems: newComments,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
      },
    );
  }
}
