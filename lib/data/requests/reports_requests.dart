import 'package:json_annotation/json_annotation.dart';

part 'reports_requests.g.dart';

@JsonSerializable()
class ReportSocialItemRequest {
  int reason;
  @JsonKey(includeIfNull: false)
  String? info;
  ReportSocialItemRequest({
    required this.reason,
    required this.info,
  });

  factory ReportSocialItemRequest.fromJson(Map<String, Object?> json) =>
      _$ReportSocialItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ReportSocialItemRequestToJson(this);
}

@JsonSerializable()
class HideReplyRequest {
  int index;
  HideReplyRequest({
    required this.index,
  });

  factory HideReplyRequest.fromJson(Map<String, Object?> json) =>
      _$HideReplyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$HideReplyRequestToJson(this);
}

@JsonSerializable()
class UpdateReportStateRequest {
  bool? blockUser;
  bool? hideContent;
  UpdateReportStateRequest({
    this.blockUser,
    this.hideContent,
  });

  factory UpdateReportStateRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateReportStateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateReportStateRequestToJson(this);
}
