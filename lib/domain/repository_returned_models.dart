import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';

class AddAnswerReturnedVals {
  String answerId;
  DateTime ownedAt;
  AddAnswerReturnedVals({
    required this.answerId,
    required this.ownedAt,
  });
}

class AuthReturnedVals {
  User user;
  String refCode;
  int exp;
  bool admin;
  bool requestedDelete;
  AuthReturnedVals({
    required this.user,
    required this.refCode,
    required this.exp,
    required this.admin,
    required this.requestedDelete,
  });
}

class AddPhoneReviewReturnedVals {
  PhoneReview phoneReview;
  int earnedPoints;
  AddPhoneReviewReturnedVals({
    required this.phoneReview,
    required this.earnedPoints,
  });
}

class ShowReportContextReturnedVals {
  Post post;
  DirectInteraction directInteraction;
  ShowReportContextReturnedVals({
    required this.post,
    required this.directInteraction,
  });
}
