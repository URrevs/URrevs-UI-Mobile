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
