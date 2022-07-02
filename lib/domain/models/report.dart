import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

class Report {
  final String id;
  final ReportType type;
  final DateTime createdAt;
  final ComplaintReason reason;
  final String? info;
  final String reporterId;
  final String reporterName;
  final String? reporterPicture;
  final String reporteeId;
  final String reporteeName;
  final String? phoneReview;
  final String? companyReview;
  final String? question;
  final String? comment;
  final String? answer;
  final String? reply;
  final bool reporteeBlocked;
  final bool contentHidden;
  const Report({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.reason,
    required this.info,
    required this.reporterId,
    required this.reporterName,
    required this.reporterPicture,
    required this.reporteeId,
    required this.reporteeName,
    required this.phoneReview,
    required this.companyReview,
    required this.question,
    required this.comment,
    required this.answer,
    required this.reply,
    required this.reporteeBlocked,
    required this.contentHidden,
  })  : assert(!(type == ReportType.phoneReview && phoneReview == null)),
        assert(!(type == ReportType.companyReview && companyReview == null)),
        assert(!(type == ReportType.phoneQuestion && question == null)),
        assert(!(type == ReportType.companyQuestion && question == null)),
        assert(!(type == ReportType.phoneComment &&
            (phoneReview == null || comment == null))),
        assert(!(type == ReportType.companyComment &&
            (companyReview == null || comment == null))),
        assert(!(type == ReportType.phoneAnswer &&
            (question == null || answer == null))),
        assert(!(type == ReportType.companyAnswer &&
            (question == null || answer == null))),
        assert(!(type == ReportType.phoneCommentReply &&
            (phoneReview == null || comment == null || reply == null))),
        assert(!(type == ReportType.companyCommentReply &&
            (companyReview == null || comment == null || reply == null))),
        assert(!(type == ReportType.phoneAnswerReply &&
            (question == null || answer == null || reply == null))),
        assert(!(type == ReportType.companyAnswerReply &&
            (question == null || answer == null || reply == null))),
        assert(!(phoneReview != null &&
            (companyReview != null || question != null))),
        assert(!(companyReview != null &&
            (phoneReview != null || question != null))),
        assert(!(question != null &&
            (phoneReview != null || companyReview != null))),
        assert(!(phoneReview == null &&
            companyReview == null &&
            question == null));

  String get postId => phoneReview ?? companyReview ?? question!;
}
