// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPhoneReviewResponse _$GetPhoneReviewResponseFromJson(
        Map<String, dynamic> json) =>
    GetPhoneReviewResponse(
      success: json['success'] as bool,
      phoneReviewSubRespone: PhoneReviewSubResponse.fromJson(
          json['review'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPhoneReviewResponseToJson(
        GetPhoneReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'review': instance.phoneReviewSubRespone,
    };

GetCompanyReviewResponse _$GetCompanyReviewResponseFromJson(
        Map<String, dynamic> json) =>
    GetCompanyReviewResponse(
      success: json['success'] as bool,
      companyReviewSubResponses: CompanyReviewSubResponse.fromJson(
          json['review'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCompanyReviewResponseToJson(
        GetCompanyReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'review': instance.companyReviewSubResponses,
    };

GetMyPhoneReviewsResponse _$GetMyPhoneReviewsResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyPhoneReviewsResponse(
      success: json['success'] as bool,
      phoneReviewsSubResponses: (json['reviews'] as List<dynamic>)
          .map(
              (e) => PhoneReviewSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyPhoneReviewsResponseToJson(
        GetMyPhoneReviewsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reviews': instance.phoneReviewsSubResponses,
    };

GetPhoneReviewsOfAnotherUserResponse
    _$GetPhoneReviewsOfAnotherUserResponseFromJson(Map<String, dynamic> json) =>
        GetPhoneReviewsOfAnotherUserResponse(
          success: json['success'] as bool,
          phoneReviewsSubResponses: (json['reviews'] as List<dynamic>)
              .map((e) =>
                  PhoneReviewSubResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetPhoneReviewsOfAnotherUserResponseToJson(
        GetPhoneReviewsOfAnotherUserResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reviews': instance.phoneReviewsSubResponses,
    };

GetMyCompanyReviewsResponse _$GetMyCompanyReviewsResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyCompanyReviewsResponse(
      success: json['success'] as bool,
      companyReviewsSubResponses: (json['reviews'] as List<dynamic>)
          .map((e) =>
              CompanyReviewSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyCompanyReviewsResponseToJson(
        GetMyCompanyReviewsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reviews': instance.companyReviewsSubResponses,
    };

GetCompanyReviewsOfAnotherUserResponse
    _$GetCompanyReviewsOfAnotherUserResponseFromJson(
            Map<String, dynamic> json) =>
        GetCompanyReviewsOfAnotherUserResponse(
          success: json['success'] as bool,
          companyReviewsSubResponses: (json['reviews'] as List<dynamic>)
              .map((e) =>
                  CompanyReviewSubResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetCompanyReviewsOfAnotherUserResponseToJson(
        GetCompanyReviewsOfAnotherUserResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reviews': instance.companyReviewsSubResponses,
    };

GetReviewsOnCertainPhoneResponse _$GetReviewsOnCertainPhoneResponseFromJson(
        Map<String, dynamic> json) =>
    GetReviewsOnCertainPhoneResponse(
      success: json['success'] as bool,
      phoneReviewsSubResponses: (json['reviews'] as List<dynamic>)
          .map(
              (e) => PhoneReviewSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetReviewsOnCertainPhoneResponseToJson(
        GetReviewsOnCertainPhoneResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reviews': instance.phoneReviewsSubResponses,
    };

LikePhoneReviewResponse _$LikePhoneReviewResponseFromJson(
        Map<String, dynamic> json) =>
    LikePhoneReviewResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$LikePhoneReviewResponseToJson(
        LikePhoneReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

UnlikePhoneReviewResponse _$UnlikePhoneReviewResponseFromJson(
        Map<String, dynamic> json) =>
    UnlikePhoneReviewResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$UnlikePhoneReviewResponseToJson(
        UnlikePhoneReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

LikeCompanyReviewResponse _$LikeCompanyReviewResponseFromJson(
        Map<String, dynamic> json) =>
    LikeCompanyReviewResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$LikeCompanyReviewResponseToJson(
        LikeCompanyReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

UnlikeCompanyReviewResponse _$UnlikeCompanyReviewResponseFromJson(
        Map<String, dynamic> json) =>
    UnlikeCompanyReviewResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$UnlikeCompanyReviewResponseToJson(
        UnlikeCompanyReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

GetCommentsAndRepliesForPhoneReviewResponse
    _$GetCommentsAndRepliesForPhoneReviewResponseFromJson(
            Map<String, dynamic> json) =>
        GetCommentsAndRepliesForPhoneReviewResponse(
          success: json['success'] as bool,
          commentsSubResponses: (json['comments'] as List<dynamic>)
              .map(
                  (e) => CommentSubResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetCommentsAndRepliesForPhoneReviewResponseToJson(
        GetCommentsAndRepliesForPhoneReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'comments': instance.commentsSubResponses,
    };

GetCommentsAndRepliesForCompanyReviewResponse
    _$GetCommentsAndRepliesForCompanyReviewResponseFromJson(
            Map<String, dynamic> json) =>
        GetCommentsAndRepliesForCompanyReviewResponse(
          success: json['success'] as bool,
          commentsSubResponses: (json['comments'] as List<dynamic>)
              .map(
                  (e) => CommentSubResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetCommentsAndRepliesForCompanyReviewResponseToJson(
        GetCommentsAndRepliesForCompanyReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'comments': instance.commentsSubResponses,
    };

AddCommentToPhoneReviewResponse _$AddCommentToPhoneReviewResponseFromJson(
        Map<String, dynamic> json) =>
    AddCommentToPhoneReviewResponse(
      success: json['success'] as bool,
      commentId: json['comment'] as String,
    );

Map<String, dynamic> _$AddCommentToPhoneReviewResponseToJson(
        AddCommentToPhoneReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'comment': instance.commentId,
    };

AddCommentToCompanyReviewResponse _$AddCommentToCompanyReviewResponseFromJson(
        Map<String, dynamic> json) =>
    AddCommentToCompanyReviewResponse(
      success: json['success'] as bool,
      commentId: json['comment'] as String,
    );

Map<String, dynamic> _$AddCommentToCompanyReviewResponseToJson(
        AddCommentToCompanyReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'comment': instance.commentId,
    };

AddReplyToPhoneReviewCommentResponse
    _$AddReplyToPhoneReviewCommentResponseFromJson(Map<String, dynamic> json) =>
        AddReplyToPhoneReviewCommentResponse(
          success: json['success'] as bool,
          replyId: json['reply'] as String,
        );

Map<String, dynamic> _$AddReplyToPhoneReviewCommentResponseToJson(
        AddReplyToPhoneReviewCommentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reply': instance.replyId,
    };

AddReplyToCompanyReviewCommentResponse
    _$AddReplyToCompanyReviewCommentResponseFromJson(
            Map<String, dynamic> json) =>
        AddReplyToCompanyReviewCommentResponse(
          success: json['success'] as bool,
          replyId: json['reply'] as String,
        );

Map<String, dynamic> _$AddReplyToCompanyReviewCommentResponseToJson(
        AddReplyToCompanyReviewCommentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reply': instance.replyId,
    };
