// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies_api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCompaniesResponse _$GetAllCompaniesResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllCompaniesResponse(
      success: json['success'] as bool,
      companiesSubResponses: (json['companies'] as List<dynamic>)
          .map((e) =>
              CompanyWithLogoSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCompaniesResponseToJson(
        GetAllCompaniesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'companies': instance.companiesSubResponses,
    };
