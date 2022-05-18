import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/answer.dart';
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

@JsonSerializable()
class GetQuestionsOnCertainPhoneResponse extends BaseResponse {
  @JsonKey(name: 'questions')
  List<QuestionSubResponse> questionsSubResponses;
  GetQuestionsOnCertainPhoneResponse({
    required bool success,
    required this.questionsSubResponses,
  }) : super(success: success);

  List<Question> get questionsModels =>
      questionsSubResponses.map((q) => q.questionModel).toList();

  factory GetQuestionsOnCertainPhoneResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetQuestionsOnCertainPhoneResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetQuestionsOnCertainPhoneResponseToJson(this);
}

@JsonSerializable()
class GetQuestionsOnCertainCompanyResponse extends BaseResponse {
  @JsonKey(name: 'questions')
  List<QuestionSubResponse> questionsSubResponses;
  GetQuestionsOnCertainCompanyResponse({
    required bool success,
    required this.questionsSubResponses,
  }) : super(success: success);

  List<Question> get questionsModels =>
      questionsSubResponses.map((q) => q.questionModel).toList();

  factory GetQuestionsOnCertainCompanyResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetQuestionsOnCertainCompanyResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetQuestionsOnCertainCompanyResponseToJson(this);
}

@JsonSerializable()
class UpvotePhoneQuestionResponse extends BaseResponse {
  String status;
  UpvotePhoneQuestionResponse({
    required bool success,
    required this.status,
  }) : super(success: success);

  factory UpvotePhoneQuestionResponse.fromJson(Map<String, Object?> json) =>
      _$UpvotePhoneQuestionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpvotePhoneQuestionResponseToJson(this);
}

@JsonSerializable()
class DownvotePhoneQuestionResponse extends BaseResponse {
  String status;
  DownvotePhoneQuestionResponse({
    required bool success,
    required this.status,
  }) : super(success: success);

  factory DownvotePhoneQuestionResponse.fromJson(Map<String, Object?> json) =>
      _$DownvotePhoneQuestionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DownvotePhoneQuestionResponseToJson(this);
}

@JsonSerializable()
class UpvoteCompanyQuestionResponse extends BaseResponse {
  String status;
  UpvoteCompanyQuestionResponse({
    required bool success,
    required this.status,
  }) : super(success: success);

  factory UpvoteCompanyQuestionResponse.fromJson(Map<String, Object?> json) =>
      _$UpvoteCompanyQuestionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpvoteCompanyQuestionResponseToJson(this);
}

@JsonSerializable()
class DownvoteCompanyQuestionResponse extends BaseResponse {
  String status;
  DownvoteCompanyQuestionResponse({
    required bool success,
    required this.status,
  }) : super(success: success);

  factory DownvoteCompanyQuestionResponse.fromJson(Map<String, Object?> json) =>
      _$DownvoteCompanyQuestionResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$DownvoteCompanyQuestionResponseToJson(this);
}

@JsonSerializable()
class GetAnswersAndRepliesForPhoneQuestionResponse extends BaseResponse {
  @JsonKey(name: 'answers')
  List<AnswerSubResponse> answersSubResponses;
  GetAnswersAndRepliesForPhoneQuestionResponse({
    required bool success,
    required this.answersSubResponses,
  }) : super(success: success);

  List<Answer> get answersModels =>
      answersSubResponses.map((a) => a.answerModel(accepted: false)).toList();

  factory GetAnswersAndRepliesForPhoneQuestionResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetAnswersAndRepliesForPhoneQuestionResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetAnswersAndRepliesForPhoneQuestionResponseToJson(this);
}

@JsonSerializable()
class GetAnswersAndRepliesForCompanyQuestionResponse extends BaseResponse {
  @JsonKey(name: 'answers')
  List<AnswerSubResponse> answersSubResponses;
  GetAnswersAndRepliesForCompanyQuestionResponse({
    required bool success,
    required this.answersSubResponses,
  }) : super(success: success);

  List<Answer> get answersModels =>
      answersSubResponses.map((a) => a.answerModel(accepted: false)).toList();

  factory GetAnswersAndRepliesForCompanyQuestionResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetAnswersAndRepliesForCompanyQuestionResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetAnswersAndRepliesForCompanyQuestionResponseToJson(this);
}

@JsonSerializable()
class AddAnswerToPhoneQuestionResponse extends BaseResponse {
  @JsonKey(name: 'answer')
  String answerId;
  AddAnswerToPhoneQuestionResponse({
    required bool success,
    required this.answerId,
  }) : super(success: success);

  factory AddAnswerToPhoneQuestionResponse.fromJson(
          Map<String, Object?> json) =>
      _$AddAnswerToPhoneQuestionResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddAnswerToPhoneQuestionResponseToJson(this);
}

@JsonSerializable()
class AddAnswerToCompanyQuestionResponse extends BaseResponse {
  @JsonKey(name: 'answer')
  String answerId;
  AddAnswerToCompanyQuestionResponse({
    required bool success,
    required this.answerId,
  }) : super(success: success);

  factory AddAnswerToCompanyQuestionResponse.fromJson(
          Map<String, Object?> json) =>
      _$AddAnswerToCompanyQuestionResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddAnswerToCompanyQuestionResponseToJson(this);
}

@JsonSerializable()
class AddReplyToPhoneQuestionAnswerResponse extends BaseResponse {
  @JsonKey(name: 'reply')
  String replyId;
  AddReplyToPhoneQuestionAnswerResponse({
    required bool success,
    required this.replyId,
  }) : super(success: success);

  factory AddReplyToPhoneQuestionAnswerResponse.fromJson(
          Map<String, Object?> json) =>
      _$AddReplyToPhoneQuestionAnswerResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddReplyToPhoneQuestionAnswerResponseToJson(this);
}

@JsonSerializable()
class AddReplyToCompanyQuestionAnswerResponse extends BaseResponse {
  @JsonKey(name: 'reply')
  String replyId;
  AddReplyToCompanyQuestionAnswerResponse({
    required bool success,
    required this.replyId,
  }) : super(success: success);

  factory AddReplyToCompanyQuestionAnswerResponse.fromJson(
          Map<String, Object?> json) =>
      _$AddReplyToCompanyQuestionAnswerResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$AddReplyToCompanyQuestionAnswerResponseToJson(this);
}

@JsonSerializable()
class MarkAnswerAsAcceptedForPhoneResponse extends BaseResponse {
  @JsonKey(name: '_id')
  String id;
  MarkAnswerAsAcceptedForPhoneResponse({
    required bool success,
    required this.id,
  }) : super(success: success);

  factory MarkAnswerAsAcceptedForPhoneResponse.fromJson(
          Map<String, Object?> json) =>
      _$MarkAnswerAsAcceptedForPhoneResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MarkAnswerAsAcceptedForPhoneResponseToJson(this);
}

@JsonSerializable()
class MarkAnswerAsAcceptedForCompanyResponse extends BaseResponse {
  @JsonKey(name: '_id')
  String id;
  MarkAnswerAsAcceptedForCompanyResponse({
    required bool success,
    required this.id,
  }) : super(success: success);

  factory MarkAnswerAsAcceptedForCompanyResponse.fromJson(
          Map<String, Object?> json) =>
      _$MarkAnswerAsAcceptedForCompanyResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MarkAnswerAsAcceptedForCompanyResponseToJson(this);
}

@JsonSerializable()
class UnmarkAnswerAsAcceptedForPhoneResponse extends BaseResponse {
  @JsonKey(name: '_id')
  String id;
  UnmarkAnswerAsAcceptedForPhoneResponse({
    required bool success,
    required this.id,
  }) : super(success: success);

  factory UnmarkAnswerAsAcceptedForPhoneResponse.fromJson(
          Map<String, Object?> json) =>
      _$UnmarkAnswerAsAcceptedForPhoneResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$UnmarkAnswerAsAcceptedForPhoneResponseToJson(this);
}

@JsonSerializable()
class UnmarkAnswerAsAcceptedForCompanyResponse extends BaseResponse {
  @JsonKey(name: '_id')
  String id;
  UnmarkAnswerAsAcceptedForCompanyResponse({
    required bool success,
    required this.id,
  }) : super(success: success);

  factory UnmarkAnswerAsAcceptedForCompanyResponse.fromJson(
          Map<String, Object?> json) =>
      _$UnmarkAnswerAsAcceptedForCompanyResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$UnmarkAnswerAsAcceptedForCompanyResponseToJson(this);
}
