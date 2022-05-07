import 'package:json_annotation/json_annotation.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';

import 'base_response.dart';

part 'reviews_api_responses.g.dart';

@JsonSerializable()
class GetPhoneReviewResponse extends BaseResponse {
  @JsonKey(name: 'review')
  ReviewSubResponse reviewSubResponses;
  GetPhoneReviewResponse({
    required bool success,
    required this.reviewSubResponses,
  }) : super(success: success);

  factory GetPhoneReviewResponse.fromJson(Map<String, Object?> json) =>
      _$GetPhoneReviewResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetPhoneReviewResponseToJson(this);
}
