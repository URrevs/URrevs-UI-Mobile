import 'package:json_annotation/json_annotation.dart';

part 'questions_api_requests.g.dart';

@JsonSerializable()
class AddPhoneQuestionRequest {
  @JsonKey(name: 'phone')
  String phonetId;
  String content;
  AddPhoneQuestionRequest({
    required this.phonetId,
    required this.content,
  });

  factory AddPhoneQuestionRequest.fromJson(Map<String, Object?> json) =>
      _$AddPhoneQuestionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddPhoneQuestionRequestToJson(this);
}

@JsonSerializable()
class AddCompanyQuestionRequest {
  @JsonKey(name: 'company')
  String companyId;
  String content;
  AddCompanyQuestionRequest({
    required this.companyId,
    required this.content,
  });

  factory AddCompanyQuestionRequest.fromJson(Map<String, Object?> json) =>
      _$AddCompanyQuestionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddCompanyQuestionRequestToJson(this);
}
