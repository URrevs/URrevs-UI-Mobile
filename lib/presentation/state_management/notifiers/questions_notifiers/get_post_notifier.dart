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
    required this.getPostForReport,
  })  : _postId = postId,
        _postType = postType,
        super(GetPostInitialState());

  final String _postId;
  final PostType _postType;
  final bool getPostForReport;

  void getPost() async {
    state = GetQuestionLoadingState();
    Either<Failure, Post> response;
    if (getPostForReport) {
      switch (_postType) {
        case PostType.phoneReview:
          response = await GetIt.I<Repository>().showReportPhoneReview(_postId);
          break;
        case PostType.companyReview:
          response =
              await GetIt.I<Repository>().showReportCompanyReview(_postId);
          break;
        case PostType.phoneQuestion:
          response =
              await GetIt.I<Repository>().showReportPhoneQuestion(_postId);
          break;
        case PostType.companyQuestion:
          response =
              await GetIt.I<Repository>().showReportCompanyQuestion(_postId);
          break;
      }
    } else {
      switch (_postType) {
        case PostType.phoneReview:
          response = await GetIt.I<Repository>().getPhoneReview(_postId);
          break;
        case PostType.companyReview:
          response = await GetIt.I<Repository>().getCompanyReview(_postId);
          break;
        case PostType.phoneQuestion:
          response = await GetIt.I<Repository>().getPhoneQuestion(_postId);
          break;
        case PostType.companyQuestion:
          response = await GetIt.I<Repository>().getCompanyQuestion(_postId);
          break;
      }
    }
    response.fold(
      (failure) => state = GetPostErrorState(failure: failure),
      (question) {
        state = GetPostLoadedState(post: question);
      },
    );
  }
}
