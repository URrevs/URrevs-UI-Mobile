import 'package:json_annotation/json_annotation.dart';
import 'package:urrevs_ui_mobile/data/responses/base_response.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
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

@JsonSerializable()
class ShowReportCommentResponse extends BaseResponse {
  @JsonKey(name: 'comment')
  CommentSubResponse commentsSubResponse;
  ShowReportCommentResponse({
    required bool success,
    required this.commentsSubResponse,
  }) : super(success: success);

  Comment get commentModel => commentsSubResponse.commentModel;

  factory ShowReportCommentResponse.fromJson(Map<String, Object?> json) =>
      _$ShowReportCommentResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ShowReportCommentResponseToJson(this);
}

@JsonSerializable()
class ShowReportAnswerResponse extends BaseResponse {
  @JsonKey(name: 'answer')
  AnswerSubResponse answerSubResponse;
  ShowReportAnswerResponse({
    required bool success,
    required this.answerSubResponse,
  }) : super(success: success);

  Answer get answerModel => answerSubResponse.answerModel(accepted: false);

  factory ShowReportAnswerResponse.fromJson(Map<String, Object?> json) =>
      _$ShowReportAnswerResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ShowReportAnswerResponseToJson(this);
}

@JsonSerializable()
class ShowReportReplyResponse extends BaseResponse {
  @JsonKey(name: 'reply')
  ReplySubResponse replySubResponse;
  ShowReportReplyResponse({
    required bool success,
    required this.replySubResponse,
  }) : super(success: success);

  ReplyModel get replyModel => replySubResponse.replyModel;

  factory ShowReportReplyResponse.fromJson(Map<String, Object?> json) =>
      _$ShowReportReplyResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ShowReportReplyResponseToJson(this);
}
