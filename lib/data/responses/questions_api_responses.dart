import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';

import 'base_response.dart';

part 'questions_api_responses.g.dart';

@JsonSerializable()
class GetPhoneQuestionResponse extends BaseResponse {
  @JsonKey(name: 'question')
  QuestionSubResponse questionSubResponse;
  GetPhoneQuestionResponse({
    required bool success,
    required this.questionSubResponse,
  }) : super(success: success);

  factory GetPhoneQuestionResponse.fromJson(Map<String, Object?> json) =>
      _$GetPhoneQuestionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetPhoneQuestionResponseToJson(this);
}

@JsonSerializable()
class GetCompanyQuestionResponse extends BaseResponse {
  @JsonKey(name: 'question')
  QuestionSubResponse questionSubResponse;
  GetCompanyQuestionResponse({
    required bool success,
    required this.questionSubResponse,
  }) : super(success: success);

  factory GetCompanyQuestionResponse.fromJson(Map<String, Object?> json) =>
      _$GetCompanyQuestionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetCompanyQuestionResponseToJson(this);
}
