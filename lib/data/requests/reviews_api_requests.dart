import 'package:json_annotation/json_annotation.dart';

part 'reviews_api_requests.g.dart';

@JsonSerializable()
class AddPhoneReviewRequest {
  String phoneId;
  String companyId;
  DateTime ownedDate;
  int generalRating;
  int uiRating;
  int manQuality;
  int valFMon;
  int camera;
  int callQuality;
  int battery;
  String pros;
  String cons;
  String? refCode;
  int companyRating;
  String compPros;
  String compCons;

  AddPhoneReviewRequest({
    required this.phoneId,
    required this.companyId,
    required this.ownedDate,
    required this.generalRating,
    required this.uiRating,
    required this.manQuality,
    required this.valFMon,
    required this.camera,
    required this.callQuality,
    required this.battery,
    required this.pros,
    required this.cons,
    required this.refCode,
    required this.companyRating,
    required this.compPros,
    required this.compCons,
  });

  factory AddPhoneReviewRequest.fromJson(Map<String, Object?> json) =>
      _$AddPhoneReviewRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddPhoneReviewRequestToJson(this);
}

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
