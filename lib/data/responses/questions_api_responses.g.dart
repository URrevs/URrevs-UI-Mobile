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
