import 'package:equatable/equatable.dart';

class UserIdProviderParam extends Equatable {
  final int providerId;
  final String? userId;
  UserIdProviderParam({
    required this.userId,
  }) : providerId = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [providerId, userId];
}

class GetUserPhoneReviewsProviderParams extends UserIdProviderParam {
  GetUserPhoneReviewsProviderParams({required String? userId})
      : super(userId: userId);
}

class GetUserCompanyReviewsProviderParams extends UserIdProviderParam {
  GetUserCompanyReviewsProviderParams({required String? userId})
      : super(userId: userId);
}
