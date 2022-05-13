import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

import '../../states/question_states/get_post_state.dart';

class GetPostNotifier extends StateNotifier<GetPostState> {
  GetPostNotifier({
    required String postId,
    required PostType postType,
  })  : _postId = postId,
        _postType = postType,
        super(GetPostInitialState());

  final String _postId;
  final PostType _postType;

  void getPost() async {
    state = GetQuestionLoadingState();
    Either<Failure, Post> response;
    switch (_postType) {
      case PostType.phoneReview:
        response = await GetIt.I<Repository>().getPhoneReview(_postId);
        break;
      case PostType.companyReview:
        response = await GetIt.I<Repository>().getCompanyReview(_postId);
        break;
      case PostType.question:
        response = await GetIt.I<Repository>().getPhoneQuestion(_postId);
        break;
      case PostType.companyQuestion:
        response = await GetIt.I<Repository>().getCompanyQuestion(_postId);
        break;
    }
    response.fold(
      (failure) => state = GetPostErrorState(failure: failure),
      (question) {
        state = GetPostLoadedState(post: question);
      },
    );
  }
}
