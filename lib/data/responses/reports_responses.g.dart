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

ShowReportPhoneReviewCommentContextResponse
    _$ShowReportPhoneReviewCommentContextResponseFromJson(
            Map<String, dynamic> json) =>
        ShowReportPhoneReviewCommentContextResponse(
          success: json['success'] as bool,
          phoneReviewSubResponse: PhoneReviewSubResponse.fromJson(
              json['review'] as Map<String, dynamic>),
          commentSubResponse: CommentSubResponse.fromJson(
              json['comment'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$ShowReportPhoneReviewCommentContextResponseToJson(
        ShowReportPhoneReviewCommentContextResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'review': instance.phoneReviewSubResponse,
      'comment': instance.commentSubResponse,
    };

ShowReportCompanyReviewCommentContextResponse
    _$ShowReportCompanyReviewCommentContextResponseFromJson(
            Map<String, dynamic> json) =>
        ShowReportCompanyReviewCommentContextResponse(
          success: json['success'] as bool,
          companyReviewSubResponse: CompanyReviewSubResponse.fromJson(
              json['review'] as Map<String, dynamic>),
          commentSubResponse: CommentSubResponse.fromJson(
              json['comment'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$ShowReportCompanyReviewCommentContextResponseToJson(
        ShowReportCompanyReviewCommentContextResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'review': instance.companyReviewSubResponse,
      'comment': instance.commentSubResponse,
    };

ShowReportAnswerContextResponse _$ShowReportAnswerContextResponseFromJson(
        Map<String, dynamic> json) =>
    ShowReportAnswerContextResponse(
      success: json['success'] as bool,
      questionSubResponse: QuestionSubResponse.fromJson(
          json['question'] as Map<String, dynamic>),
      answerSubResponse:
          AnswerSubResponse.fromJson(json['answer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowReportAnswerContextResponseToJson(
        ShowReportAnswerContextResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'question': instance.questionSubResponse,
      'answer': instance.answerSubResponse,
    };
