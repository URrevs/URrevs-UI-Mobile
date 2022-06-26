import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
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
  AuthReturnedVals({
    required this.user,
    required this.refCode,
    required this.exp,
    required this.admin,
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
