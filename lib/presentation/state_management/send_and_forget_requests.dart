import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

class SendAndForgetRequests {
  static Future<void> increaseViewCount({
    required String postId,
    required TargetType targetType,
  }) async {
    switch (targetType) {
      case TargetType.phone:
        await GetIt.I<Repository>().increaseViewCountForPhoneReview(postId);
        break;
      case TargetType.company:
        await GetIt.I<Repository>().increaseViewCountForCompanyReview(postId);
        break;
    }
  }

  static Future<void> increaseShareCount({
    required String postId,
    required TargetType targetType,
    required PostContentType postContentType,
  }) async {
    switch (postContentType) {
      case PostContentType.review:
        switch (targetType) {
          case TargetType.phone:
            await GetIt.I<Repository>()
                .increaseShareCountForPhoneReview(postId);
            break;
          case TargetType.company:
            await GetIt.I<Repository>()
                .increaseShareCountForCompanyReview(postId);
            break;
        }
        break;
      case PostContentType.question:
        switch (targetType) {
          case TargetType.phone:
            await GetIt.I<Repository>()
                .increaseShareCountForPhoneQuestion(postId);
            break;
          case TargetType.company:
            await GetIt.I<Repository>()
                .increaseShareCountForCompanyQuestion(postId);
            break;
        }
        break;
    }
  }

  static Future<void> userPressesSeeMore({
    required String postId,
    required TargetType targetType,
  }) async {
    switch (targetType) {
      case TargetType.phone:
        await GetIt.I<Repository>().userPressesSeeMoreInPhoneReview(postId);
        break;
      case TargetType.company:
        await GetIt.I<Repository>().userPressesSeeMoreInCompanyReview(postId);
        break;
    }
  }

  static Future<void> userPressesFullscreen({
    required String postId,
    required TargetType targetType,
    required PostContentType postContentType,
  }) async {
    switch (postContentType) {
      case PostContentType.review:
        switch (targetType) {
          case TargetType.phone:
            await GetIt.I<Repository>()
                .userPressesFullscreenInPhoneReview(postId);
            break;
          case TargetType.company:
            await GetIt.I<Repository>()
                .userPressesFullscreenInCompanyReview(postId);
            break;
        }
        break;
      case PostContentType.question:
        switch (targetType) {
          case TargetType.phone:
            await GetIt.I<Repository>()
                .userPressesFullscreenInPhoneQuestion(postId);
            break;
          case TargetType.company:
            await GetIt.I<Repository>()
                .userPressesFullscreenInCompanyQuestion(postId);
            break;
        }
        break;
    }
  }
}
