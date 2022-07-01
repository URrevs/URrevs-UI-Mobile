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
