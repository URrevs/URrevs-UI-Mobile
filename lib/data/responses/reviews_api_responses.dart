import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';

import 'base_response.dart';

part 'reviews_api_responses.g.dart';

@JsonSerializable()
class AddPhoneReviewResponse extends BaseResponse {
  @JsonKey(name: 'review')
  PhoneReviewForAddPhoneReviewSubResponse phoneReviewSubRespone;
  int earnedPoints;
  AddPhoneReviewResponse({
    required bool success,
    required this.phoneReviewSubRespone,
    required this.earnedPoints,
  }) : super(success: success);

  factory AddPhoneReviewResponse.fromJson(Map<String, Object?> json) =>
      _$AddPhoneReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AddPhoneReviewResponseToJson(this);
}

@JsonSerializable()
class GetPhoneReviewResponse extends BaseResponse {
  @JsonKey(name: 'review')
  PhoneReviewSubResponse phoneReviewSubRespone;
  GetPhoneReviewResponse({
    required bool success,
    required this.phoneReviewSubRespone,
  }) : super(success: success);

  factory GetPhoneReviewResponse.fromJson(Map<String, Object?> json) =>
      _$GetPhoneReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetPhoneReviewResponseToJson(this);
}

@JsonSerializable()
class GetCompanyReviewResponse extends BaseResponse {
  @JsonKey(name: 'review')
  CompanyReviewSubResponse companyReviewSubResponses;
  GetCompanyReviewResponse({
    required bool success,
    required this.companyReviewSubResponses,
  }) : super(success: success);

  factory GetCompanyReviewResponse.fromJson(Map<String, Object?> json) =>
      _$GetCompanyReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetCompanyReviewResponseToJson(this);
}

@JsonSerializable()
class GetMyPhoneReviewsResponse extends BaseResponse {
  @JsonKey(name: 'reviews')
  List<PhoneReviewSubResponse> phoneReviewsSubResponses;
  GetMyPhoneReviewsResponse({
    required bool success,
    required this.phoneReviewsSubResponses,
  }) : super(success: success);

  List<PhoneReview> get phoneReviewsModels =>
      phoneReviewsSubResponses.map((p) => p.phoneReviewModel).toList();

  factory GetMyPhoneReviewsResponse.fromJson(Map<String, Object?> json) =>
      _$GetMyPhoneReviewsResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetMyPhoneReviewsResponseToJson(this);
}

@JsonSerializable()
class GetPhoneReviewsOfAnotherUserResponse extends BaseResponse {
  @JsonKey(name: 'reviews')
  List<PhoneReviewSubResponse> phoneReviewsSubResponses;
  GetPhoneReviewsOfAnotherUserResponse({
    required bool success,
    required this.phoneReviewsSubResponses,
  }) : super(success: success);

  List<PhoneReview> get phoneReviewsModels =>
      phoneReviewsSubResponses.map((p) => p.phoneReviewModel).toList();

  factory GetPhoneReviewsOfAnotherUserResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetPhoneReviewsOfAnotherUserResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetPhoneReviewsOfAnotherUserResponseToJson(this);
}

@JsonSerializable()
class GetMyCompanyReviewsResponse extends BaseResponse {
  @JsonKey(name: 'reviews')
  List<CompanyReviewSubResponse> companyReviewsSubResponses;
  GetMyCompanyReviewsResponse({
    required bool success,
    required this.companyReviewsSubResponses,
  }) : super(success: success);

  List<CompanyReview> get companyReviewsModels =>
      companyReviewsSubResponses.map((c) => c.companyReviewModel).toList();

  factory GetMyCompanyReviewsResponse.fromJson(Map<String, Object?> json) =>
      _$GetMyCompanyReviewsResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetMyCompanyReviewsResponseToJson(this);
}

@JsonSerializable()
class GetCompanyReviewsOfAnotherUserResponse extends BaseResponse {
  @JsonKey(name: 'reviews')
  List<CompanyReviewSubResponse> companyReviewsSubResponses;
  GetCompanyReviewsOfAnotherUserResponse({
    required bool success,
    required this.companyReviewsSubResponses,
  }) : super(success: success);

  List<CompanyReview> get companyReviewsModels =>
      companyReviewsSubResponses.map((c) => c.companyReviewModel).toList();

  factory GetCompanyReviewsOfAnotherUserResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetCompanyReviewsOfAnotherUserResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetCompanyReviewsOfAnotherUserResponseToJson(this);
}

@JsonSerializable()
class GetReviewsOnCertainPhoneResponse extends BaseResponse {
  @JsonKey(name: 'reviews')
  List<PhoneReviewSubResponse> phoneReviewsSubResponses;
  GetReviewsOnCertainPhoneResponse({
    required bool success,
    required this.phoneReviewsSubResponses,
  }) : super(success: success);

  List<PhoneReview> get phoneReviewsModels =>
      phoneReviewsSubResponses.map((p) => p.phoneReviewModel).toList();

  factory GetReviewsOnCertainPhoneResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetReviewsOnCertainPhoneResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetReviewsOnCertainPhoneResponseToJson(this);
}

@JsonSerializable()
class GetReviewsOnCertainCompanyResponse extends BaseResponse {
  @JsonKey(name: 'reviews')
  List<CompanyReviewSubResponse> companyReviewSubResponse;
  GetReviewsOnCertainCompanyResponse({
    required bool success,
    required this.companyReviewSubResponse,
  }) : super(success: success);

  List<CompanyReview> get companyReviewsModels =>
      companyReviewSubResponse.map((c) => c.companyReviewModel).toList();

  factory GetReviewsOnCertainCompanyResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetReviewsOnCertainCompanyResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetReviewsOnCertainCompanyResponseToJson(this);
}

@JsonSerializable()
class LikePhoneReviewResponse extends BaseResponse {
  LikePhoneReviewResponse({
    required bool success,
  }) : super(success: success);

  factory LikePhoneReviewResponse.fromJson(Map<String, Object?> json) =>
      _$LikePhoneReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LikePhoneReviewResponseToJson(this);
}

@JsonSerializable()
class UnlikePhoneReviewResponse extends BaseResponse {
  UnlikePhoneReviewResponse({
    required bool success,
  }) : super(success: success);

  factory UnlikePhoneReviewResponse.fromJson(Map<String, Object?> json) =>
      _$UnlikePhoneReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UnlikePhoneReviewResponseToJson(this);
}

@JsonSerializable()
class LikeCompanyReviewResponse extends BaseResponse {
  LikeCompanyReviewResponse({
    required bool success,
  }) : super(success: success);

  factory LikeCompanyReviewResponse.fromJson(Map<String, Object?> json) =>
      _$LikeCompanyReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LikeCompanyReviewResponseToJson(this);
}

@JsonSerializable()
class UnlikeCompanyReviewResponse extends BaseResponse {
  UnlikeCompanyReviewResponse({
    required bool success,
  }) : super(success: success);

  factory UnlikeCompanyReviewResponse.fromJson(Map<String, Object?> json) =>
      _$UnlikeCompanyReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UnlikeCompanyReviewResponseToJson(this);
}

@JsonSerializable()
class GetCommentsAndRepliesForPhoneReviewResponse extends BaseResponse {
  @JsonKey(name: 'comments')
  List<CommentSubResponse> commentsSubResponses;
  GetCommentsAndRepliesForPhoneReviewResponse({
    required bool success,
    required this.commentsSubResponses,
  }) : super(success: success);

  List<Comment> get commentsModels =>
      commentsSubResponses.map((c) => c.commentModel).toList();

  factory GetCommentsAndRepliesForPhoneReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetCommentsAndRepliesForPhoneReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetCommentsAndRepliesForPhoneReviewResponseToJson(this);
}

@JsonSerializable()
class GetCommentsAndRepliesForCompanyReviewResponse extends BaseResponse {
  @JsonKey(name: 'comments')
  List<CommentSubResponse> commentsSubResponses;
  GetCommentsAndRepliesForCompanyReviewResponse({
    required bool success,
    required this.commentsSubResponses,
  }) : super(success: success);

  List<Comment> get commentsModels =>
      commentsSubResponses.map((c) => c.commentModel).toList();

  factory GetCommentsAndRepliesForCompanyReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetCommentsAndRepliesForCompanyReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetCommentsAndRepliesForCompanyReviewResponseToJson(this);
}

@JsonSerializable()
class AddCommentToPhoneReviewResponse extends BaseResponse {
  @JsonKey(name: 'comment')
  String commentId;
  AddCommentToPhoneReviewResponse({
    required bool success,
    required this.commentId,
  }) : super(success: success);

  factory AddCommentToPhoneReviewResponse.fromJson(Map<String, Object?> json) =>
      _$AddCommentToPhoneReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$AddCommentToPhoneReviewResponseToJson(this);
}

@JsonSerializable()
class AddCommentToCompanyReviewResponse extends BaseResponse {
  @JsonKey(name: 'comment')
  String commentId;
  AddCommentToCompanyReviewResponse({
    required bool success,
    required this.commentId,
  }) : super(success: success);

  factory AddCommentToCompanyReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$AddCommentToCompanyReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$AddCommentToCompanyReviewResponseToJson(this);
}

@JsonSerializable()
class AddReplyToPhoneReviewCommentResponse extends BaseResponse {
  @JsonKey(name: 'reply')
  String replyId;
  AddReplyToPhoneReviewCommentResponse({
    required bool success,
    required this.replyId,
  }) : super(success: success);

  factory AddReplyToPhoneReviewCommentResponse.fromJson(
          Map<String, Object?> json) =>
      _$AddReplyToPhoneReviewCommentResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$AddReplyToPhoneReviewCommentResponseToJson(this);
}

@JsonSerializable()
class AddReplyToCompanyReviewCommentResponse extends BaseResponse {
  @JsonKey(name: 'reply')
  String replyId;
  AddReplyToCompanyReviewCommentResponse({
    required bool success,
    required this.replyId,
  }) : super(success: success);

  factory AddReplyToCompanyReviewCommentResponse.fromJson(
          Map<String, Object?> json) =>
      _$AddReplyToCompanyReviewCommentResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$AddReplyToCompanyReviewCommentResponseToJson(this);
}

@JsonSerializable()
class LikePhoneReviewCommentResponse extends BaseResponse {
  LikePhoneReviewCommentResponse({
    required bool success,
  }) : super(success: success);

  factory LikePhoneReviewCommentResponse.fromJson(Map<String, Object?> json) =>
      _$LikePhoneReviewCommentResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LikePhoneReviewCommentResponseToJson(this);
}

@JsonSerializable()
class UnlikePhoneReviewCommentResponse extends BaseResponse {
  UnlikePhoneReviewCommentResponse({
    required bool success,
  }) : super(success: success);

  factory UnlikePhoneReviewCommentResponse.fromJson(
          Map<String, Object?> json) =>
      _$UnlikePhoneReviewCommentResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$UnlikePhoneReviewCommentResponseToJson(this);
}

@JsonSerializable()
class LikeCompanyReviewCommentResponse extends BaseResponse {
  LikeCompanyReviewCommentResponse({
    required bool success,
  }) : super(success: success);

  factory LikeCompanyReviewCommentResponse.fromJson(
          Map<String, Object?> json) =>
      _$LikeCompanyReviewCommentResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$LikeCompanyReviewCommentResponseToJson(this);
}

@JsonSerializable()
class UnlikeCompanyReviewCommentResponse extends BaseResponse {
  UnlikeCompanyReviewCommentResponse({
    required bool success,
  }) : super(success: success);

  factory UnlikeCompanyReviewCommentResponse.fromJson(
          Map<String, Object?> json) =>
      _$UnlikeCompanyReviewCommentResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$UnlikeCompanyReviewCommentResponseToJson(this);
}

@JsonSerializable()
class LikePhoneReviewReplyResponse extends BaseResponse {
  LikePhoneReviewReplyResponse({
    required bool success,
  }) : super(success: success);

  factory LikePhoneReviewReplyResponse.fromJson(Map<String, Object?> json) =>
      _$LikePhoneReviewReplyResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LikePhoneReviewReplyResponseToJson(this);
}

@JsonSerializable()
class UnlikePhoneReviewReplyResponse extends BaseResponse {
  UnlikePhoneReviewReplyResponse({
    required bool success,
  }) : super(success: success);

  factory UnlikePhoneReviewReplyResponse.fromJson(Map<String, Object?> json) =>
      _$UnlikePhoneReviewReplyResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UnlikePhoneReviewReplyResponseToJson(this);
}

@JsonSerializable()
class LikeCompanyReviewReplyResponse extends BaseResponse {
  LikeCompanyReviewReplyResponse({
    required bool success,
  }) : super(success: success);

  factory LikeCompanyReviewReplyResponse.fromJson(Map<String, Object?> json) =>
      _$LikeCompanyReviewReplyResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LikeCompanyReviewReplyResponseToJson(this);
}

@JsonSerializable()
class UnlikeCompanyReviewReplyResponse extends BaseResponse {
  UnlikeCompanyReviewReplyResponse({
    required bool success,
  }) : super(success: success);

  factory UnlikeCompanyReviewReplyResponse.fromJson(
          Map<String, Object?> json) =>
      _$UnlikeCompanyReviewReplyResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$UnlikeCompanyReviewReplyResponseToJson(this);
}

@JsonSerializable()
class IDontLikeThisForPhoneReviewResponse extends BaseResponse {
  IDontLikeThisForPhoneReviewResponse({
    required bool success,
  }) : super(success: success);

  factory IDontLikeThisForPhoneReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$IDontLikeThisForPhoneReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$IDontLikeThisForPhoneReviewResponseToJson(this);
}

@JsonSerializable()
class IDontLikeThisForCompanyReviewResponse extends BaseResponse {
  IDontLikeThisForCompanyReviewResponse({
    required bool success,
  }) : super(success: success);

  factory IDontLikeThisForCompanyReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$IDontLikeThisForCompanyReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$IDontLikeThisForCompanyReviewResponseToJson(this);
}

@JsonSerializable()
class IncreaseViewCountForPhoneReviewResponse extends BaseResponse {
  IncreaseViewCountForPhoneReviewResponse({
    required bool success,
  }) : super(success: success);

  factory IncreaseViewCountForPhoneReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$IncreaseViewCountForPhoneReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$IncreaseViewCountForPhoneReviewResponseToJson(this);
}

@JsonSerializable()
class IncreaseViewCountForCompanyReviewResponse extends BaseResponse {
  IncreaseViewCountForCompanyReviewResponse({
    required bool success,
  }) : super(success: success);

  factory IncreaseViewCountForCompanyReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$IncreaseViewCountForCompanyReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$IncreaseViewCountForCompanyReviewResponseToJson(this);
}

@JsonSerializable()
class IncreaseShareCountForPhoneReviewResponse extends BaseResponse {
  IncreaseShareCountForPhoneReviewResponse({
    required bool success,
  }) : super(success: success);

  factory IncreaseShareCountForPhoneReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$IncreaseShareCountForPhoneReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$IncreaseShareCountForPhoneReviewResponseToJson(this);
}

@JsonSerializable()
class IncreaseShareCountForCompanyReviewResponse extends BaseResponse {
  IncreaseShareCountForCompanyReviewResponse({
    required bool success,
  }) : super(success: success);

  factory IncreaseShareCountForCompanyReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$IncreaseShareCountForCompanyReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$IncreaseShareCountForCompanyReviewResponseToJson(this);
}

@JsonSerializable()
class UserPressesSeeMoreInPhoneReviewResponse extends BaseResponse {
  UserPressesSeeMoreInPhoneReviewResponse({
    required bool success,
  }) : super(success: success);

  factory UserPressesSeeMoreInPhoneReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$UserPressesSeeMoreInPhoneReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$UserPressesSeeMoreInPhoneReviewResponseToJson(this);
}

@JsonSerializable()
class UserPressesSeeMoreInCompanyReviewResponse extends BaseResponse {
  UserPressesSeeMoreInCompanyReviewResponse({
    required bool success,
  }) : super(success: success);

  factory UserPressesSeeMoreInCompanyReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$UserPressesSeeMoreInCompanyReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$UserPressesSeeMoreInCompanyReviewResponseToJson(this);
}

@JsonSerializable()
class UserPressesFullscreenInPhoneReviewResponse extends BaseResponse {
  UserPressesFullscreenInPhoneReviewResponse({
    required bool success,
  }) : super(success: success);

  factory UserPressesFullscreenInPhoneReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$UserPressesFullscreenInPhoneReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$UserPressesFullscreenInPhoneReviewResponseToJson(this);
}

@JsonSerializable()
class UserPressesFullscreenInCompanyReviewResponse extends BaseResponse {
  UserPressesFullscreenInCompanyReviewResponse({
    required bool success,
  }) : super(success: success);

  factory UserPressesFullscreenInCompanyReviewResponse.fromJson(
          Map<String, Object?> json) =>
      _$UserPressesFullscreenInCompanyReviewResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$UserPressesFullscreenInCompanyReviewResponseToJson(this);
}
