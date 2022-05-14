import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';

class Answer extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String? photo;
  final DateTime createdAt;
  final DateTime ownedAt;
  final String content;
  final int upvotes;
  final bool upvoted;
  final List<ReplyModel> replies;
  const Answer({
    required this.id,
    required this.userId,
    required this.userName,
    required this.photo,
    required this.createdAt,
    required this.ownedAt,
    required this.content,
    required this.upvotes,
    required this.upvoted,
    required this.replies,
  });

  @override
  List<Object?> get props => [id];
}
