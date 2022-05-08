import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

import '../../../../domain/failure.dart';

class LikePostNotifier extends StateNotifier<bool> {
  LikePostNotifier({required String postId, required PostType postType})
      : _postId = postId,
        _postType = postType,
        super(false);

  final String _postId;
  final PostType _postType;

  void setLikedState(bool value) => state = value;

  void _like() async {
    setLikedState(true);
    late Either<Failure, void> response;
    if (_postType == PostType.phoneReview) {
      response = await GetIt.I<Repository>().likePhoneReview(_postId);
    } else {
      response = await GetIt.I<Repository>().likeCompanyReview(_postId);
    }
    response.fold(
      (failure) => setLikedState(false),
      (_) => null,
    );
  }

  void _unlike() async {
    setLikedState(false);
    late Either<Failure, void> response;
    if (_postType == PostType.phoneReview) {
      response = await GetIt.I<Repository>().unlikePhoneReview(_postId);
    } else {
      response = await GetIt.I<Repository>().unlikeCompanyReview(_postId);
    }
    response.fold(
      (failure) => setLikedState(true),
      (_) => null,
    );
  }

  void toggleLikeState() {
    if (state == true) {
      _unlike();
    } else {
      _like();
    }
  }
}
