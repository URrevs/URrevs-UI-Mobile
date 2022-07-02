// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetReportsResponse _$GetReportsResponseFromJson(Map<String, dynamic> json) =>
    GetReportsResponse(
      success: json['success'] as bool,
      reportsSubResponses: (json['reports'] as List<dynamic>)
          .map((e) => ReportSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetReportsResponseToJson(GetReportsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reports': instance.reportsSubResponses,
    };

ShowReportCommentResponse _$ShowReportCommentResponseFromJson(
        Map<String, dynamic> json) =>
    ShowReportCommentResponse(
      success: json['success'] as bool,
      commentsSubResponse:
          CommentSubResponse.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowReportCommentResponseToJson(
        ShowReportCommentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'comment': instance.commentsSubResponse,
    };

ShowReportAnswerResponse _$ShowReportAnswerResponseFromJson(
        Map<String, dynamic> json) =>
    ShowReportAnswerResponse(
      success: json['success'] as bool,
      answerSubResponse:
          AnswerSubResponse.fromJson(json['answer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowReportAnswerResponseToJson(
        ShowReportAnswerResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'answer': instance.answerSubResponse,
    };

ShowReportReplyResponse _$ShowReportReplyResponseFromJson(
        Map<String, dynamic> json) =>
    ShowReportReplyResponse(
      success: json['success'] as bool,
      replySubResponse:
          ReplySubResponse.fromJson(json['reply'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowReportReplyResponseToJson(
        ShowReportReplyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reply': instance.replySubResponse,
    };
