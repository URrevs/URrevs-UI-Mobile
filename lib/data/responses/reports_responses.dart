import 'package:json_annotation/json_annotation.dart';
import 'package:urrevs_ui_mobile/data/responses/base_response.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';

part 'reports_responses.g.dart';

@JsonSerializable()
class GetReportsResponse extends BaseResponse {
  @JsonKey(name: 'reports')
  List<ReportSubResponse> reportsSubResponses;
  GetReportsResponse({
    required bool success,
    required this.reportsSubResponses,
  }) : super(success: success);

  List<Report> get reportsModels =>
      reportsSubResponses.map((r) => r.reportModel).toList();

  factory GetReportsResponse.fromJson(Map<String, Object?> json) =>
      _$GetReportsResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetReportsResponseToJson(this);
}
