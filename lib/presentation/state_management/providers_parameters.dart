import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

abstract class BaseProviderParams extends Equatable {
  final int providerId;
  BaseProviderParams() : providerId = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [providerId];
}

abstract class UserIdProviderParams extends BaseProviderParams {
  final String? userId;
  UserIdProviderParams({
    required this.userId,
  });

  @override
  List<Object?> get props => [providerId, userId];
}

class GetUserPhoneReviewsProviderParams extends UserIdProviderParams {
  GetUserPhoneReviewsProviderParams({required String? userId})
      : super(userId: userId);
}

class GetUserCompanyReviewsProviderParams extends UserIdProviderParams {
  GetUserCompanyReviewsProviderParams({required String? userId})
      : super(userId: userId);
}

class GetReviewsOnCertainPhoneProviderParams extends BaseProviderParams {
  final String phoneId;
  GetReviewsOnCertainPhoneProviderParams({
    required this.phoneId,
  });

  @override
  List<Object?> get props => [providerId, phoneId];
}

class LikeProviderParams extends Equatable {
  final String socialItemId;
  final String? replyParentId;
  final PostType postType;
  final InteractionType? interactionType;
  const LikeProviderParams({
    required this.socialItemId,
    required this.replyParentId,
    required this.postType,
    required this.interactionType,
  });

  @override
  List<Object?> get props =>
      [socialItemId, replyParentId, postType, interactionType];
}

class GetCommentsProviderParams extends BaseProviderParams {
  final String postId;
  final PostType postType;
  GetCommentsProviderParams({
    required this.postId,
    required this.postType,
  });

  @override
  List<Object?> get props => [postId, postType, providerId];
}

class AddCommentProviderParams extends BaseProviderParams {
  AddCommentProviderParams();
}

class AddReviewReplyProviderParams extends BaseProviderParams {
  AddReviewReplyProviderParams();
}
