import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';

import 'base_response.dart';

part 'reviews_api_responses.g.dart';

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
  Map<String, dynamic> toJson() =>
      _$GetReviewsOnCertainPhoneResponseToJson(this);
}

@JsonSerializable()
class LikePhoneReviewResponse extends BaseResponse {
  LikePhoneReviewResponse({
    required bool success,
  }) : super(success: success);

  factory LikePhoneReviewResponse.fromJson(Map<String, Object?> json) =>
      _$LikePhoneReviewResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LikePhoneReviewResponseToJson(this);
}

@JsonSerializable()
class UnlikePhoneReviewResponse extends BaseResponse {
  UnlikePhoneReviewResponse({
    required bool success,
  }) : super(success: success);

  factory UnlikePhoneReviewResponse.fromJson(Map<String, Object?> json) =>
      _$UnlikePhoneReviewResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UnlikePhoneReviewResponseToJson(this);
}

@JsonSerializable()
class LikeCompanyReviewResponse extends BaseResponse {
  LikeCompanyReviewResponse({
    required bool success,
  }) : super(success: success);

  factory LikeCompanyReviewResponse.fromJson(Map<String, Object?> json) =>
      _$LikeCompanyReviewResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LikeCompanyReviewResponseToJson(this);
}

@JsonSerializable()
class UnlikeCompanyReviewResponse extends BaseResponse {
  UnlikeCompanyReviewResponse({
    required bool success,
  }) : super(success: success);

  factory UnlikeCompanyReviewResponse.fromJson(Map<String, Object?> json) =>
      _$UnlikeCompanyReviewResponseFromJson(json);
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
  Map<String, dynamic> toJson() =>
      _$AddCommentToCompanyReviewResponseToJson(this);
}
