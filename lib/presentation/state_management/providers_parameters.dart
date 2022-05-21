import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

/// Subclasses of [NotSyncedProviderParams] do not have to extend [Equatable] as
/// non of those provider would ever be equal to another one.
abstract class NotSyncedProviderParams extends Equatable {
  final int providerId;
  NotSyncedProviderParams()
      : providerId = DateTime.now().millisecondsSinceEpoch;

  @override
  @mustCallSuper
  List<Object?> get props => [providerId];
}

abstract class UserIdProviderParams extends NotSyncedProviderParams {
  final String? userId;
  UserIdProviderParams({
    required this.userId,
  });

  @override
  @mustCallSuper
  List<Object?> get props => [userId, ...super.props];
}

class GetTheProfileOfAnotherUserProviderParams extends NotSyncedProviderParams {
  GetTheProfileOfAnotherUserProviderParams();
}

class GetOwnedPhonesProviderParams extends UserIdProviderParams {
  GetOwnedPhonesProviderParams({required String? userId})
      : super(userId: userId);
}

class GetAllCompaniesProviderParams extends NotSyncedProviderParams {
  GetAllCompaniesProviderParams();
}

class GetAllPhonesProviderParams extends NotSyncedProviderParams {
  GetAllPhonesProviderParams();
}

class GetInfoAboutLatestUpdateProviderParams extends NotSyncedProviderParams {
  GetInfoAboutLatestUpdateProviderParams();
}

class GetTwoPhonesSpecsProviderParams extends NotSyncedProviderParams {
  GetTwoPhonesSpecsProviderParams();
}

class GetPhoneSpecsProviderParams extends NotSyncedProviderParams {
  GetPhoneSpecsProviderParams();
}

class GetPhoneStatisticalInfoProviderParams extends NotSyncedProviderParams {
  GetPhoneStatisticalInfoProviderParams();
}

class GetCompanyStatisticalInfoProviderParams extends NotSyncedProviderParams {
  GetCompanyStatisticalInfoProviderParams();
}

class GetSimilarPhonesProviderParams extends NotSyncedProviderParams {
  GetSimilarPhonesProviderParams();
}

class SearchProviderParams extends NotSyncedProviderParams {
  final SearchMode searchMode;
  SearchProviderParams({
    required this.searchMode,
  });
}

class GetPostsListProviderParams extends NotSyncedProviderParams {
  GetPostsListProviderParams() : super();
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
  List<Object?> get props => [phoneId, ...super.props];
}

class LikeProviderParams extends Equatable {
  final String socialItemId;
  final String? replyParentId;
  final PostType postType;
  final InteractionType? interactionType;
  final GetInteractionsProviderParams? getInteractionsProviderParams;
  const LikeProviderParams({
    required this.socialItemId,
    required this.replyParentId,
    required this.postType,
    required this.interactionType,
    required this.getInteractionsProviderParams,
  });

  @override
  List<Object?> get props =>
      [socialItemId, replyParentId, postType, interactionType];
}

class GetInteractionsProviderParams extends NotSyncedProviderParams {
  final String postId;
  final PostType postType;
  GetInteractionsProviderParams({
    required this.postId,
    required this.postType,
  });

  @override
  List<Object?> get props => [postId, postType, ...super.props];
}

class AddInteractionProviderParams extends NotSyncedProviderParams {
  final String postId;
  final PostType postType;
  AddInteractionProviderParams({
    required this.postId,
    required this.postType,
  });
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

class AcceptAnswerProviderParams extends Equatable {
  final String questionId;
  final String answerId;
  final TargetType targetType;
  final GetInteractionsProviderParams? getInteractionsProviderParams;
  const AcceptAnswerProviderParams({
    required this.questionId,
    required this.answerId,
    required this.targetType,
    required this.getInteractionsProviderParams,
  });

  @override
  List<Object?> get props =>
      [questionId, answerId, targetType, getInteractionsProviderParams];
}

class PostProviderParams extends Equatable {
  final String postId;
  final PostType postType;
  final Post? post;
  const PostProviderParams({
    required this.postId,
    required this.postType,
    required this.post,
  });

  @override
  List<Object?> get props => [postId, postType];
}

class DirectInteractionProviderParams extends Equatable {
  final String interactionId;
  final InteractionType interactionType;
  final DirectInteraction interaction;
  const DirectInteractionProviderParams({
    required this.interactionId,
    required this.interactionType,
    required this.interaction,
  });

  @override
  List<Object?> get props => [interactionId, interactionType];
}

class ReplyProviderParams extends Equatable {
  final String replyId;
  final ReplyModel reply;
  const ReplyProviderParams({
    required this.replyId,
    required this.reply,
  });

  @override
  List<Object?> get props => [replyId];
}

class IDontLikeThisProviderParams extends Equatable {
  final String postId;
  final PostContentType postContentType;
  final TargetType targetType;

  const IDontLikeThisProviderParams({
    required this.postId,
    required this.postContentType,
    required this.targetType,
  });

  @override
  List<Object?> get props => [postId, postContentType, targetType];
}
