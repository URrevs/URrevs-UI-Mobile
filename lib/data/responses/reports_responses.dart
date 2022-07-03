import 'package:json_annotation/json_annotation.dart';
import 'package:urrevs_ui_mobile/data/responses/base_response.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/domain/repository_returned_models.dart';

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

@JsonSerializable()
class ShowReportPhoneReviewCommentContextResponse extends BaseResponse {
  @JsonKey(name: 'review')
  PhoneReviewSubResponse phoneReviewSubResponse;
  @JsonKey(name: 'comment')
  CommentSubResponse commentSubResponse;
  ShowReportPhoneReviewCommentContextResponse({
    required bool success,
    required this.phoneReviewSubResponse,
    required this.commentSubResponse,
  }) : super(success: success);

  PhoneReview get phoneReviewModel => phoneReviewSubResponse.phoneReviewModel;
  Comment get commentModel => commentSubResponse.commentModel;

  ShowReportContextReturnedVals get returnedVals {
    return ShowReportContextReturnedVals(
      post: phoneReviewModel,
      directInteraction: commentModel,
    );
  }

  factory ShowReportPhoneReviewCommentContextResponse.fromJson(
          Map<String, Object?> json) =>
      _$ShowReportPhoneReviewCommentContextResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$ShowReportPhoneReviewCommentContextResponseToJson(this);
}

@JsonSerializable()
class ShowReportCompanyReviewCommentContextResponse extends BaseResponse {
  @JsonKey(name: 'review')
  CompanyReviewSubResponse companyReviewSubResponse;
  @JsonKey(name: 'comment')
  CommentSubResponse commentSubResponse;
  ShowReportCompanyReviewCommentContextResponse({
    required bool success,
    required this.companyReviewSubResponse,
    required this.commentSubResponse,
  }) : super(success: success);

  CompanyReview get companyReviewModel =>
      companyReviewSubResponse.companyReviewModel;
  Comment get commentModel => commentSubResponse.commentModel;

  ShowReportContextReturnedVals get returnedVals {
    return ShowReportContextReturnedVals(
      post: companyReviewModel,
      directInteraction: commentModel,
    );
  }

  factory ShowReportCompanyReviewCommentContextResponse.fromJson(
          Map<String, Object?> json) =>
      _$ShowReportCompanyReviewCommentContextResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$ShowReportCompanyReviewCommentContextResponseToJson(this);
}

@JsonSerializable()
class ShowReportAnswerContextResponse extends BaseResponse {
  @JsonKey(name: 'question')
  QuestionSubResponse questionSubResponse;
  @JsonKey(name: 'answer')
  AnswerSubResponse answerSubResponse;
  ShowReportAnswerContextResponse({
    required bool success,
    required this.questionSubResponse,
    required this.answerSubResponse,
  }) : super(success: success);

  Question get questionModel => questionSubResponse.questionModel;
  Answer get answerModel => answerSubResponse.answerModel(accepted: false);

  ShowReportContextReturnedVals get returnedVals {
    return ShowReportContextReturnedVals(
      post: questionModel,
      directInteraction: answerModel,
    );
  }

  factory ShowReportAnswerContextResponse.fromJson(Map<String, Object?> json) =>
      _$ShowReportAnswerContextResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$ShowReportAnswerContextResponseToJson(this);
}
