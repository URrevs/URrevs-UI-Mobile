// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'misc_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostsForHomeScreenResponse _$GetPostsForHomeScreenResponseFromJson(
        Map<String, dynamic> json) =>
    GetPostsForHomeScreenResponse(
      success: json['success'] as bool,
      phoneReviewsSubResponses: (json['phoneRevs'] as List<dynamic>)
          .map(
              (e) => PhoneReviewSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      companyReviewsSubResponses: (json['companyRevs'] as List<dynamic>)
          .map((e) =>
              CompanyReviewSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      phoneQuestionsSubResponses: (json['phoneQuestions'] as List<dynamic>)
          .map((e) => QuestionSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      companyQuestionsSubResponses: (json['companyQuestions'] as List<dynamic>)
          .map((e) => QuestionSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      postsIds:
          (json['total'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GetPostsForHomeScreenResponseToJson(
        GetPostsForHomeScreenResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'phoneRevs': instance.phoneReviewsSubResponses,
      'companyRevs': instance.companyReviewsSubResponses,
      'phoneQuestions': instance.phoneQuestionsSubResponses,
      'companyQuestions': instance.companyQuestionsSubResponses,
      'total': instance.postsIds,
    };