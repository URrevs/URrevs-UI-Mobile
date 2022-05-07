import 'package:json_annotation/json_annotation.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';

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
