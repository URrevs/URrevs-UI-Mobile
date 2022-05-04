// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTargetFromSourceResponse _$UpdateTargetFromSourceResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateTargetFromSourceResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UpdateTargetFromSourceResponseToJson(
        UpdateTargetFromSourceResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

GetInfoAboutLatestUpdateResponse _$GetInfoAboutLatestUpdateResponseFromJson(
        Map<String, dynamic> json) =>
    GetInfoAboutLatestUpdateResponse(
      success: json['success'] as bool,
      numPhones: json['numPhones'] as int,
      numCompanies: json['numCompanies'] as int,
      phonesSubResponses: (json['phones'] as List<dynamic>)
          .map((e) => PhoneSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      companiesSubResponses: (json['companies'] as List<dynamic>)
          .map((e) => CompanySubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: DateTime.parse(json['date'] as String),
      isUpdating: json['isUpdating'] as bool,
      failed: json['failed'] as bool,
      automatic: json['automatic'] as bool,
    );

Map<String, dynamic> _$GetInfoAboutLatestUpdateResponseToJson(
        GetInfoAboutLatestUpdateResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'numPhones': instance.numPhones,
      'numCompanies': instance.numCompanies,
      'phones': instance.phonesSubResponses,
      'companies': instance.companiesSubResponses,
      'date': instance.date.toIso8601String(),
      'isUpdating': instance.isUpdating,
      'failed': instance.failed,
      'automatic': instance.automatic,
    };
