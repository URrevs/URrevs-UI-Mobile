import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';

class Answer extends Equatable {
  String id;
  String userId;
  String userName;
  String? photo;
  DateTime createdAt;
  String content;
  int upvotes;
  bool upvoted;
  List<ReplyModel> replies;
  Answer({
    required this.id,
    required this.userId,
    required this.userName,
    required this.photo,
    required this.createdAt,
    required this.content,
    required this.upvotes,
    required this.upvoted,
    required this.replies,
  });

  @override
  List<Object?> get props => [id];
}
