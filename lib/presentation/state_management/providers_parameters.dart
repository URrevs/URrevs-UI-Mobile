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
}

class LikePostProviderParams extends Equatable {
  final String postId;
  final PostType postType;
  const LikePostProviderParams({
    required this.postId,
    required this.postType,
  });

  @override
  List<Object?> get props => [postId, postType];
}
