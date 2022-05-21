import 'package:json_annotation/json_annotation.dart';

part 'base_requests.g.dart';

@JsonSerializable()
class AddInteractionRequest {
  String content;
  AddInteractionRequest({
    required this.content,
  });

  AddAnswerToPhoneQuestionRequest toAddAnswerToPhoneQuestionRequest(
      String phoneId) {
    return AddAnswerToPhoneQuestionRequest(content: content, phoneId: phoneId);
  }

  AddAnswerToCompanyQuestionRequest toAddAnswerToCompanyQuestionRequest(
      String companyId) {
    return AddAnswerToCompanyQuestionRequest(
        content: content, companyId: companyId);
  }

  factory AddInteractionRequest.fromJson(Map<String, Object?> json) =>
      _$AddInteractionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddInteractionRequestToJson(this);
}

@JsonSerializable()
class AddAnswerToPhoneQuestionRequest extends AddInteractionRequest {
  String phoneId;
  AddAnswerToPhoneQuestionRequest({
    required String content,
    required this.phoneId,
  }) : super(content: content);

  factory AddAnswerToPhoneQuestionRequest.fromJson(Map<String, Object?> json) =>
      _$AddAnswerToPhoneQuestionRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddAnswerToPhoneQuestionRequestToJson(this);
}

@JsonSerializable()
class AddAnswerToCompanyQuestionRequest extends AddInteractionRequest {
  String companyId;
  AddAnswerToCompanyQuestionRequest({
    required String content,
    required this.companyId,
  }) : super(content: content);

  factory AddAnswerToCompanyQuestionRequest.fromJson(
          Map<String, Object?> json) =>
      _$AddAnswerToCompanyQuestionRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddAnswerToCompanyQuestionRequestToJson(this);
}
