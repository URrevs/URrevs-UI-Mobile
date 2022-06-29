// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportPostRequest _$ReportPostRequestFromJson(Map<String, dynamic> json) =>
    ReportPostRequest(
      reason: json['reason'] as int,
      info: json['info'] as String?,
    );

Map<String, dynamic> _$ReportPostRequestToJson(ReportPostRequest instance) {
  final val = <String, dynamic>{
    'reason': instance.reason,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('info', instance.info);
  return val;
}
