// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions_api_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPhoneQuestionRequest _$AddPhoneQuestionRequestFromJson(
        Map<String, dynamic> json) =>
    AddPhoneQuestionRequest(
      phonetId: json['phone'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$AddPhoneQuestionRequestToJson(
        AddPhoneQuestionRequest instance) =>
    <String, dynamic>{
      'phone': instance.phonetId,
      'content': instance.content,
    };

AddCompanyQuestionRequest _$AddCompanyQuestionRequestFromJson(
        Map<String, dynamic> json) =>
    AddCompanyQuestionRequest(
      companyId: json['company'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$AddCompanyQuestionRequestToJson(
        AddCompanyQuestionRequest instance) =>
    <String, dynamic>{
      'company': instance.companyId,
      'content': instance.content,
    };
