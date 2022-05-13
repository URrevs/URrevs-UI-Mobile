import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

/// Subclasses of [NotSyncedProviderParams] do not have to extend [Equatable] as
/// non of those provider would ever be equal to another one.
abstract class NotSyncedProviderParams extends Equatable {
  final int providerId;
  NotSyncedProviderParams()
      : providerId = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [providerId];
}

class SearchProviderParams extends NotSyncedProviderParams {
  final SearchMode searchMode;
  SearchProviderParams({
    required this.searchMode,
  });
}

abstract class UserIdProviderParams extends NotSyncedProviderParams {
  final String? userId;
  UserIdProviderParams({
    required this.userId,
  });

  @override
  List<Object?> get props => [providerId, userId];
}

class GetUserPostsProviderParams extends UserIdProviderParams {
  GetUserPostsProviderParams({
    required String? userId,
    required this.postContentType,
  }) : super(userId: userId);

  PostContentType postContentType;
}

class GetUserCompanyReviewsProviderParams extends UserIdProviderParams {
  GetUserCompanyReviewsProviderParams({required String? userId})
      : super(userId: userId);
}

class GetReviewsOnCertainPhoneProviderParams extends NotSyncedProviderParams {
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

class GetCommentsProviderParams extends NotSyncedProviderParams {
  final String postId;
  final PostType postType;
  GetCommentsProviderParams({
    required this.postId,
    required this.postType,
  });

  @override
  List<Object?> get props => [postId, postType, providerId];
}

class AddCommentProviderParams extends NotSyncedProviderParams {
  AddCommentProviderParams();
}

class AddReviewReplyProviderParams extends NotSyncedProviderParams {
  AddReviewReplyProviderParams();
}

class GetPhoneManufacturingCompanyProviderParams
    extends NotSyncedProviderParams {
  GetPhoneManufacturingCompanyProviderParams();
}

class AddPhoneReviewProviderParams extends NotSyncedProviderParams {
  AddPhoneReviewProviderParams();
}

class GetPostProviderParams extends NotSyncedProviderParams {
  final String postId;
  final PostType postType;
  GetPostProviderParams({
    required this.postId,
    required this.postType,
  });
}
