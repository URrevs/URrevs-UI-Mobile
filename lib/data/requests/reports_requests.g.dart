// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportSocialItemRequest _$ReportSocialItemRequestFromJson(
        Map<String, dynamic> json) =>
    ReportSocialItemRequest(
      reason: json['reason'] as int,
      info: json['info'] as String?,
    );

Map<String, dynamic> _$ReportSocialItemRequestToJson(
    ReportSocialItemRequest instance) {
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
