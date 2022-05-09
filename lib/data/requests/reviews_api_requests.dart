import 'package:json_annotation/json_annotation.dart';

part 'reviews_api_requests.g.dart';

class GetPhoneReviewRequest {}

class GetCompanyReviewRequest {}

class GetMyPhoneReviewsRequest {}

class GetPhoneReviewsOfAnotherUserRequest {}

class GetMyCompanyReviewsRequest {}

class GetCompanyReviewsOfAnotherUserRequest {}

class GetReviewsOnCertainPhoneRequest {}

@JsonSerializable()
class AddCommentToPhoneReviewRequest {
  String content;
  AddCommentToPhoneReviewRequest({
    required this.content,
  });

  factory AddCommentToPhoneReviewRequest.fromJson(Map<String, Object?> json) =>
      _$AddCommentToPhoneReviewRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddCommentToPhoneReviewRequestToJson(this);
}

@JsonSerializable()
class AddCommentToCompanyReviewRequest {
  String content;
  AddCommentToCompanyReviewRequest({
    required this.content,
  });

  factory AddCommentToCompanyReviewRequest.fromJson(
          Map<String, Object?> json) =>
      _$AddCommentToCompanyReviewRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddCommentToCompanyReviewRequestToJson(this);
}

@JsonSerializable()
class AddReplyToPhoneReviewCommentRequest {
  String content;
  AddReplyToPhoneReviewCommentRequest({
    required this.content,
  });

  factory AddReplyToPhoneReviewCommentRequest.fromJson(
          Map<String, Object?> json) =>
      _$AddReplyToPhoneReviewCommentRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddReplyToPhoneReviewCommentRequestToJson(this);
}

@JsonSerializable()
class AddReplyToCompanyReviewCommentRequest {
  String content;
  AddReplyToCompanyReviewCommentRequest({
    required this.content,
  });

  factory AddReplyToCompanyReviewCommentRequest.fromJson(
          Map<String, Object?> json) =>
      _$AddReplyToCompanyReviewCommentRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddReplyToCompanyReviewCommentRequestToJson(this);
}
