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
  AuthReturnedVals({
    required this.user,
    required this.refCode,
  });
}
