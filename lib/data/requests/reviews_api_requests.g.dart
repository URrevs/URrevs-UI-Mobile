// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_api_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPhoneReviewRequest _$AddPhoneReviewRequestFromJson(
        Map<String, dynamic> json) =>
    AddPhoneReviewRequest(
      phoneId: json['phoneId'] as String,
      companyId: json['companyId'] as String,
      ownedDate: DateTime.parse(json['ownedDate'] as String),
      generalRating: json['generalRating'] as int,
      uiRating: json['uiRating'] as int,
      manQuality: json['manQuality'] as int,
      valFMon: json['valFMon'] as int,
      camera: json['camera'] as int,
      callQuality: json['callQuality'] as int,
      battery: json['battery'] as int,
      pros: json['pros'] as String,
      cons: json['cons'] as String,
      refCode: json['refCode'] as String?,
      companyRating: json['companyRating'] as int,
      compPros: json['compPros'] as String,
      compCons: json['compCons'] as String,
    );

Map<String, dynamic> _$AddPhoneReviewRequestToJson(
        AddPhoneReviewRequest instance) =>
    <String, dynamic>{
      'phoneId': instance.phoneId,
      'companyId': instance.companyId,
      'ownedDate': instance.ownedDate.toIso8601String(),
      'generalRating': instance.generalRating,
      'uiRating': instance.uiRating,
      'manQuality': instance.manQuality,
      'valFMon': instance.valFMon,
      'camera': instance.camera,
      'callQuality': instance.callQuality,
      'battery': instance.battery,
      'pros': instance.pros,
      'cons': instance.cons,
      'refCode': instance.refCode,
      'companyRating': instance.companyRating,
      'compPros': instance.compPros,
      'compCons': instance.compCons,
    };

AddCommentToPhoneReviewRequest _$AddCommentToPhoneReviewRequestFromJson(
        Map<String, dynamic> json) =>
    AddCommentToPhoneReviewRequest(
      content: json['content'] as String,
    );

Map<String, dynamic> _$AddCommentToPhoneReviewRequestToJson(
        AddCommentToPhoneReviewRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

AddCommentToCompanyReviewRequest _$AddCommentToCompanyReviewRequestFromJson(
        Map<String, dynamic> json) =>
    AddCommentToCompanyReviewRequest(
      content: json['content'] as String,
    );

Map<String, dynamic> _$AddCommentToCompanyReviewRequestToJson(
        AddCommentToCompanyReviewRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

AddReplyToPhoneReviewCommentRequest
    _$AddReplyToPhoneReviewCommentRequestFromJson(Map<String, dynamic> json) =>
        AddReplyToPhoneReviewCommentRequest(
          content: json['content'] as String,
        );

Map<String, dynamic> _$AddReplyToPhoneReviewCommentRequestToJson(
        AddReplyToPhoneReviewCommentRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

AddReplyToCompanyReviewCommentRequest
    _$AddReplyToCompanyReviewCommentRequestFromJson(
            Map<String, dynamic> json) =>
        AddReplyToCompanyReviewCommentRequest(
          content: json['content'] as String,
        );

Map<String, dynamic> _$AddReplyToCompanyReviewCommentRequestToJson(
        AddReplyToCompanyReviewCommentRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
    };
