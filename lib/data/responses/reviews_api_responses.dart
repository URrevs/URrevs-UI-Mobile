import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
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
