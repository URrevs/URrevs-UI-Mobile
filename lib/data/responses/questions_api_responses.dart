import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/quesiton.dart';

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

@JsonSerializable()
class GetMyPhoneQuestionsResponse extends BaseResponse {
  @JsonKey(name: 'questions')
  List<QuestionSubResponse> questionsSubResponses;
  GetMyPhoneQuestionsResponse({
    required bool success,
    required this.questionsSubResponses,
  }) : super(success: success);

  List<Question> get questionsModels =>
      questionsSubResponses.map((q) => q.questionModel).toList();

  factory GetMyPhoneQuestionsResponse.fromJson(Map<String, Object?> json) =>
      _$GetMyPhoneQuestionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetMyPhoneQuestionsResponseToJson(this);
}

@JsonSerializable()
class GetMyCompanyQuestionsResponse extends BaseResponse {
  @JsonKey(name: 'questions')
  List<QuestionSubResponse> questionsSubResponses;
  GetMyCompanyQuestionsResponse({
    required bool success,
    required this.questionsSubResponses,
  }) : super(success: success);

  List<Question> get questionsModels =>
      questionsSubResponses.map((q) => q.questionModel).toList();

  factory GetMyCompanyQuestionsResponse.fromJson(Map<String, Object?> json) =>
      _$GetMyCompanyQuestionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetMyCompanyQuestionsResponseToJson(this);
}

@JsonSerializable()
class GetPhoneQuestionsOfAnotherUser extends BaseResponse {
  @JsonKey(name: 'questions')
  List<QuestionSubResponse> questionsSubResponses;
  GetPhoneQuestionsOfAnotherUser({
    required bool success,
    required this.questionsSubResponses,
  }) : super(success: success);

  List<Question> get questionsModels =>
      questionsSubResponses.map((q) => q.questionModel).toList();

  factory GetPhoneQuestionsOfAnotherUser.fromJson(Map<String, Object?> json) =>
      _$GetPhoneQuestionsOfAnotherUserFromJson(json);
  Map<String, dynamic> toJson() => _$GetPhoneQuestionsOfAnotherUserToJson(this);
}

@JsonSerializable()
class GetCompanyQuestionsOfAnotherUser extends BaseResponse {
  @JsonKey(name: 'questions')
  List<QuestionSubResponse> questionsSubResponses;
  GetCompanyQuestionsOfAnotherUser({
    required bool success,
    required this.questionsSubResponses,
  }) : super(success: success);

  List<Question> get questionsModels =>
      questionsSubResponses.map((q) => q.questionModel).toList();

  factory GetCompanyQuestionsOfAnotherUser.fromJson(
          Map<String, Object?> json) =>
      _$GetCompanyQuestionsOfAnotherUserFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetCompanyQuestionsOfAnotherUserToJson(this);
}
