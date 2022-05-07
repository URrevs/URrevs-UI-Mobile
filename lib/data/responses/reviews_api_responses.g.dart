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
