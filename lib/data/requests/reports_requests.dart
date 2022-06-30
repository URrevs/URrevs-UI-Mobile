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
