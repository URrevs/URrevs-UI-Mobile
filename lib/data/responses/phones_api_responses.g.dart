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
