// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPhoneReviewResponse _$AddPhoneReviewResponseFromJson(
        Map<String, dynamic> json) =>
    AddPhoneReviewResponse(
      success: json['success'] as bool,
      phoneReviewSubRespone: PhoneReviewForAddPhoneReviewSubResponse.fromJson(
          json['review'] as Map<String, dynamic>),
      earnedPoints: json['earnedPoints'] as int,
    );

Map<String, dynamic> _$AddPhoneReviewResponseToJson(
        AddPhoneReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'review': instance.phoneReviewSubRespone,
      'earnedPoints': instance.earnedPoints,
    };

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

GetReviewsOnCertainCompanyResponse _$GetReviewsOnCertainCompanyResponseFromJson(
        Map<String, dynamic> json) =>
    GetReviewsOnCertainCompanyResponse(
      success: json['success'] as bool,
      companyReviewSubResponse: (json['reviews'] as List<dynamic>)
          .map((e) =>
              CompanyReviewSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetReviewsOnCertainCompanyResponseToJson(
        GetReviewsOnCertainCompanyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reviews': instance.companyReviewSubResponse,
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

LikePhoneReviewCommentResponse _$LikePhoneReviewCommentResponseFromJson(
        Map<String, dynamic> json) =>
    LikePhoneReviewCommentResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$LikePhoneReviewCommentResponseToJson(
        LikePhoneReviewCommentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

UnlikePhoneReviewCommentResponse _$UnlikePhoneReviewCommentResponseFromJson(
        Map<String, dynamic> json) =>
    UnlikePhoneReviewCommentResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$UnlikePhoneReviewCommentResponseToJson(
        UnlikePhoneReviewCommentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

LikeCompanyReviewCommentResponse _$LikeCompanyReviewCommentResponseFromJson(
        Map<String, dynamic> json) =>
    LikeCompanyReviewCommentResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$LikeCompanyReviewCommentResponseToJson(
        LikeCompanyReviewCommentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

UnlikeCompanyReviewCommentResponse _$UnlikeCompanyReviewCommentResponseFromJson(
        Map<String, dynamic> json) =>
    UnlikeCompanyReviewCommentResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$UnlikeCompanyReviewCommentResponseToJson(
        UnlikeCompanyReviewCommentResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

LikePhoneReviewReplyResponse _$LikePhoneReviewReplyResponseFromJson(
        Map<String, dynamic> json) =>
    LikePhoneReviewReplyResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$LikePhoneReviewReplyResponseToJson(
        LikePhoneReviewReplyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

UnlikePhoneReviewReplyResponse _$UnlikePhoneReviewReplyResponseFromJson(
        Map<String, dynamic> json) =>
    UnlikePhoneReviewReplyResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$UnlikePhoneReviewReplyResponseToJson(
        UnlikePhoneReviewReplyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

LikeCompanyReviewReplyResponse _$LikeCompanyReviewReplyResponseFromJson(
        Map<String, dynamic> json) =>
    LikeCompanyReviewReplyResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$LikeCompanyReviewReplyResponseToJson(
        LikeCompanyReviewReplyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

UnlikeCompanyReviewReplyResponse _$UnlikeCompanyReviewReplyResponseFromJson(
        Map<String, dynamic> json) =>
    UnlikeCompanyReviewReplyResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$UnlikeCompanyReviewReplyResponseToJson(
        UnlikeCompanyReviewReplyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

IDontLikeThisForPhoneReviewResponse
    _$IDontLikeThisForPhoneReviewResponseFromJson(Map<String, dynamic> json) =>
        IDontLikeThisForPhoneReviewResponse(
          success: json['success'] as bool,
        );

Map<String, dynamic> _$IDontLikeThisForPhoneReviewResponseToJson(
        IDontLikeThisForPhoneReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

IDontLikeThisForCompanyReviewResponse
    _$IDontLikeThisForCompanyReviewResponseFromJson(
            Map<String, dynamic> json) =>
        IDontLikeThisForCompanyReviewResponse(
          success: json['success'] as bool,
        );

Map<String, dynamic> _$IDontLikeThisForCompanyReviewResponseToJson(
        IDontLikeThisForCompanyReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

IncreaseViewCountForPhoneReviewResponse
    _$IncreaseViewCountForPhoneReviewResponseFromJson(
            Map<String, dynamic> json) =>
        IncreaseViewCountForPhoneReviewResponse(
          success: json['success'] as bool,
        );

Map<String, dynamic> _$IncreaseViewCountForPhoneReviewResponseToJson(
        IncreaseViewCountForPhoneReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

IncreaseViewCountForCompanyReviewResponse
    _$IncreaseViewCountForCompanyReviewResponseFromJson(
            Map<String, dynamic> json) =>
        IncreaseViewCountForCompanyReviewResponse(
          success: json['success'] as bool,
        );

Map<String, dynamic> _$IncreaseViewCountForCompanyReviewResponseToJson(
        IncreaseViewCountForCompanyReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

IncreaseShareCountForPhoneReviewResponse
    _$IncreaseShareCountForPhoneReviewResponseFromJson(
            Map<String, dynamic> json) =>
        IncreaseShareCountForPhoneReviewResponse(
          success: json['success'] as bool,
        );

Map<String, dynamic> _$IncreaseShareCountForPhoneReviewResponseToJson(
        IncreaseShareCountForPhoneReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

IncreaseShareCountForCompanyReviewResponse
    _$IncreaseShareCountForCompanyReviewResponseFromJson(
            Map<String, dynamic> json) =>
        IncreaseShareCountForCompanyReviewResponse(
          success: json['success'] as bool,
        );

Map<String, dynamic> _$IncreaseShareCountForCompanyReviewResponseToJson(
        IncreaseShareCountForCompanyReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

UserPressesSeeMoreInPhoneReviewResponse
    _$UserPressesSeeMoreInPhoneReviewResponseFromJson(
            Map<String, dynamic> json) =>
        UserPressesSeeMoreInPhoneReviewResponse(
          success: json['success'] as bool,
        );

Map<String, dynamic> _$UserPressesSeeMoreInPhoneReviewResponseToJson(
        UserPressesSeeMoreInPhoneReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

UserPressesSeeMoreInCompanyReviewResponse
    _$UserPressesSeeMoreInCompanyReviewResponseFromJson(
            Map<String, dynamic> json) =>
        UserPressesSeeMoreInCompanyReviewResponse(
          success: json['success'] as bool,
        );

Map<String, dynamic> _$UserPressesSeeMoreInCompanyReviewResponseToJson(
        UserPressesSeeMoreInCompanyReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

UserPressesFullscreenInPhoneReviewResponse
    _$UserPressesFullscreenInPhoneReviewResponseFromJson(
            Map<String, dynamic> json) =>
        UserPressesFullscreenInPhoneReviewResponse(
          success: json['success'] as bool,
        );

Map<String, dynamic> _$UserPressesFullscreenInPhoneReviewResponseToJson(
        UserPressesFullscreenInPhoneReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

UserPressesFullscreenInCompanyReviewResponse
    _$UserPressesFullscreenInCompanyReviewResponseFromJson(
            Map<String, dynamic> json) =>
        UserPressesFullscreenInCompanyReviewResponse(
          success: json['success'] as bool,
        );

Map<String, dynamic> _$UserPressesFullscreenInCompanyReviewResponseToJson(
        UserPressesFullscreenInCompanyReviewResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };
