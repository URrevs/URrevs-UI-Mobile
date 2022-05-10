// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phones_api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllPhonesResponse _$GetAllPhonesResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllPhonesResponse(
      success: json['success'] as bool,
      phonesSubResponses: (json['phones'] as List<dynamic>)
          .map((e) => PhoneWithCompanyLogogSubResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllPhonesResponseToJson(
        GetAllPhonesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'phones': instance.phonesSubResponses,
    };

GetPhonesFromCertainCompanyResponse
    _$GetPhonesFromCertainCompanyResponseFromJson(Map<String, dynamic> json) =>
        GetPhonesFromCertainCompanyResponse(
          success: json['success'] as bool,
          phonesSubResponses: (json['phones'] as List<dynamic>)
              .map((e) => PhoneWithCompanyLogogSubResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetPhonesFromCertainCompanyResponseToJson(
        GetPhonesFromCertainCompanyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'phones': instance.phonesSubResponses,
    };

GetPhoneManufacturingCompanyResponse
    _$GetPhoneManufacturingCompanyResponseFromJson(Map<String, dynamic> json) =>
        GetPhoneManufacturingCompanyResponse(
          success: json['success'] as bool,
          companySubResponse: CompanySubResponse.fromJson(
              json['company'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$GetPhoneManufacturingCompanyResponseToJson(
        GetPhoneManufacturingCompanyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'company': instance.companySubResponse,
    };

GetPhoneSpecsResponse _$GetPhoneSpecsResponseFromJson(
        Map<String, dynamic> json) =>
    GetPhoneSpecsResponse(
      success: json['success'] as bool,
      specsSubResponse:
          SpecsSubResponse.fromJson(json['specs'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPhoneSpecsResponseToJson(
        GetPhoneSpecsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'specs': instance.specsSubResponse,
    };

GetPhoneStatisticalInfoResponse _$GetPhoneStatisticalInfoResponseFromJson(
        Map<String, dynamic> json) =>
    GetPhoneStatisticalInfoResponse(
      success: json['success'] as bool,
      infoSubResponse:
          InfoSubResponse.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPhoneStatisticalInfoResponseToJson(
        GetPhoneStatisticalInfoResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'stats': instance.infoSubResponse,
    };

IndicateUserComparedBetweenTwoPhonesResponse
    _$IndicateUserComparedBetweenTwoPhonesResponseFromJson(
            Map<String, dynamic> json) =>
        IndicateUserComparedBetweenTwoPhonesResponse(
          success: json['success'] as bool,
          status: json['status'] as String,
        );

Map<String, dynamic> _$IndicateUserComparedBetweenTwoPhonesResponseToJson(
        IndicateUserComparedBetweenTwoPhonesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

GetSimilarPhonesResponse _$GetSimilarPhonesResponseFromJson(
        Map<String, dynamic> json) =>
    GetSimilarPhonesResponse(
      success: json['success'] as bool,
      phonesSubResponses: (json['phones'] as List<dynamic>)
          .map((e) =>
              PhoneWithPictureSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSimilarPhonesResponseToJson(
        GetSimilarPhonesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'phones': instance.phonesSubResponses,
    };
