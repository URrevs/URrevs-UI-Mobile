// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions_api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPhoneQuestionResponse _$GetPhoneQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    GetPhoneQuestionResponse(
      success: json['success'] as bool,
      questionSubResponse: QuestionSubResponse.fromJson(
          json['question'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPhoneQuestionResponseToJson(
        GetPhoneQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'question': instance.questionSubResponse,
    };

GetCompanyQuestionResponse _$GetCompanyQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    GetCompanyQuestionResponse(
      success: json['success'] as bool,
      questionSubResponse: QuestionSubResponse.fromJson(
          json['question'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCompanyQuestionResponseToJson(
        GetCompanyQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'question': instance.questionSubResponse,
    };

GetMyPhoneQuestionsResponse _$GetMyPhoneQuestionsResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyPhoneQuestionsResponse(
      success: json['success'] as bool,
      questionsSubResponses: (json['questions'] as List<dynamic>)
          .map((e) => QuestionSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyPhoneQuestionsResponseToJson(
        GetMyPhoneQuestionsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'questions': instance.questionsSubResponses,
    };

GetMyCompanyQuestionsResponse _$GetMyCompanyQuestionsResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyCompanyQuestionsResponse(
      success: json['success'] as bool,
      questionsSubResponses: (json['questions'] as List<dynamic>)
          .map((e) => QuestionSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyCompanyQuestionsResponseToJson(
        GetMyCompanyQuestionsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'questions': instance.questionsSubResponses,
    };

GetPhoneQuestionsOfAnotherUser _$GetPhoneQuestionsOfAnotherUserFromJson(
        Map<String, dynamic> json) =>
    GetPhoneQuestionsOfAnotherUser(
      success: json['success'] as bool,
      questionsSubResponses: (json['questions'] as List<dynamic>)
          .map((e) => QuestionSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPhoneQuestionsOfAnotherUserToJson(
        GetPhoneQuestionsOfAnotherUser instance) =>
    <String, dynamic>{
      'success': instance.success,
      'questions': instance.questionsSubResponses,
    };

GetCompanyQuestionsOfAnotherUser _$GetCompanyQuestionsOfAnotherUserFromJson(
        Map<String, dynamic> json) =>
    GetCompanyQuestionsOfAnotherUser(
      success: json['success'] as bool,
      questionsSubResponses: (json['questions'] as List<dynamic>)
          .map((e) => QuestionSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCompanyQuestionsOfAnotherUserToJson(
        GetCompanyQuestionsOfAnotherUser instance) =>
    <String, dynamic>{
      'success': instance.success,
      'questions': instance.questionsSubResponses,
    };

UpvotePhoneQuestionResponse _$UpvotePhoneQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    UpvotePhoneQuestionResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UpvotePhoneQuestionResponseToJson(
        UpvotePhoneQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

DownvotePhoneQuestionResponse _$DownvotePhoneQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    DownvotePhoneQuestionResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$DownvotePhoneQuestionResponseToJson(
        DownvotePhoneQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

UpvoteCompanyQuestionResponse _$UpvoteCompanyQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    UpvoteCompanyQuestionResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UpvoteCompanyQuestionResponseToJson(
        UpvoteCompanyQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

DownvoteCompanyQuestionResponse _$DownvoteCompanyQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    DownvoteCompanyQuestionResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$DownvoteCompanyQuestionResponseToJson(
        DownvoteCompanyQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };
