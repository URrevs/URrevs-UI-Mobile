// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddInteractionRequest _$AddInteractionRequestFromJson(
        Map<String, dynamic> json) =>
    AddInteractionRequest(
      content: json['content'] as String,
    );

Map<String, dynamic> _$AddInteractionRequestToJson(
        AddInteractionRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

AddAnswerToPhoneQuestionRequest _$AddAnswerToPhoneQuestionRequestFromJson(
        Map<String, dynamic> json) =>
    AddAnswerToPhoneQuestionRequest(
      content: json['content'] as String,
      phoneId: json['phoneId'] as String,
    );

Map<String, dynamic> _$AddAnswerToPhoneQuestionRequestToJson(
        AddAnswerToPhoneQuestionRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'phoneId': instance.phoneId,
    };

AddAnswerToCompanyQuestionRequest _$AddAnswerToCompanyQuestionRequestFromJson(
        Map<String, dynamic> json) =>
    AddAnswerToCompanyQuestionRequest(
      content: json['content'] as String,
      companyId: json['companyId'] as String,
    );

Map<String, dynamic> _$AddAnswerToCompanyQuestionRequestToJson(
        AddAnswerToCompanyQuestionRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'companyId': instance.companyId,
    };
