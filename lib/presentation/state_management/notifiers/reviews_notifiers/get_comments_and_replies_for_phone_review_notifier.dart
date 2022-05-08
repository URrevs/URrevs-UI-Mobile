import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

import '../../states/reviews_states/get_comments_state.dart';

class GetCommentsNotifier extends StateNotifier<GetCommentsState> {
  GetCommentsNotifier(
      {required String postId, required PostType postType})
      : _postId = postId,
        _postType = postType,
        super(GetCommentsInitialState());

  int _round = 1;

  String _postId;

  PostType _postType;

  List<Comment> _currentComments = [];

  void getComments() async {
    // get current items in the state
    List<Comment> currentComments = _currentComments;
    final currentState = state;
    if (currentState is GetCommentsLoadedState) {
      currentComments = currentState.infiniteScrollingItems;
    }
    // send the request
    state = GetCommentsLoadingState();
    late Either<Failure, List<Comment>> response;
    if (_postType == PostType.phoneReview) {
      response = await GetIt.I<Repository>()
          .getCommentsAndRepliesForPhoneReview(_postId, _round);
    } else {
      response = await GetIt.I<Repository>()
          .getCommentsAndRepliesForCompanyReview(_postId, _round);
    }
    response.fold(
      // deal with failure
      (failure) => state =
          GetCommentsErrorState(failure: failure),
      (comments) {
        // add items and rounds ended state to the loaded state
        bool roundsEnded = comments.isEmpty;
        List<Comment> newComments = [...currentComments, ...comments];
        _currentComments = [...newComments];
        state = GetCommentsLoadedState(
          infiniteScrollingItems: newComments,
          roundsEnded: roundsEnded,
        );
        // increment rounds
        _round++;
      },
    );
  }
}
