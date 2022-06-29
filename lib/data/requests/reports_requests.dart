import 'package:json_annotation/json_annotation.dart';

part 'reports_requests.g.dart';

@JsonSerializable()
class ReportPostRequest {
  int reason;
  @JsonKey(includeIfNull: false)
  String? info;
  ReportPostRequest({
    required this.reason,
    required this.info,
  });

  factory ReportPostRequest.fromJson(Map<String, Object?> json) =>
      _$ReportPostRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ReportPostRequestToJson(this);
}
