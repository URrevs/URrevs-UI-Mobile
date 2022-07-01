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

HideReplyRequest _$HideReplyRequestFromJson(Map<String, dynamic> json) =>
    HideReplyRequest(
      index: json['index'] as int,
    );

Map<String, dynamic> _$HideReplyRequestToJson(HideReplyRequest instance) =>
    <String, dynamic>{
      'index': instance.index,
    };

UpdateReportStateRequest _$UpdateReportStateRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateReportStateRequest(
      blockUser: json['blockUser'] as bool?,
      hideContent: json['hideContent'] as bool?,
    );

Map<String, dynamic> _$UpdateReportStateRequestToJson(
    UpdateReportStateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('blockUser', instance.blockUser);
  writeNotNull('hideContent', instance.hideContent);
  return val;
}
