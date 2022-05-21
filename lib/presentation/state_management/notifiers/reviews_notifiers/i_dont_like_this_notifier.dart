import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';

import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

import '../../states/reviews_states/i_dont_like_this_state.dart';

class IDontLikeThisNotifier extends StateNotifier<IDontLikeThisState> {
  IDontLikeThisNotifier({
    required this.postId,
    required this.postContentType,
    required this.targetType,
  }) : super(IDontLikeThisInitialState());

  final String postId;
  final PostContentType postContentType;
  final TargetType targetType;

  void iDontLikeThis() async {
    state = IDontLikeThisLoadingState();
    Either<Failure, void> response;
    switch (postContentType) {
      case PostContentType.review:
        switch (targetType) {
          case TargetType.phone:
            response =
                await GetIt.I<Repository>().iDontLikeThisForPhoneReview(postId);
            break;
          case TargetType.company:
            response = await GetIt.I<Repository>()
                .iDontLikeThisForCompanyReview(postId);
            break;
        }
        break;
      case PostContentType.question:
        switch (targetType) {
          case TargetType.phone:
            response = await GetIt.I<Repository>()
                .iDontLikeThisForPhoneQuestion(postId);
            break;
          case TargetType.company:
            response = await GetIt.I<Repository>()
                .iDontLikeThisForCompanyQuestion(postId);
            break;
        }
        break;
    }
    response.fold(
      (failure) => state = IDontLikeThisErrorState(failure: failure),
      (_) {
        state = IDontLikeThisLoadedState();
      },
    );
  }
}
