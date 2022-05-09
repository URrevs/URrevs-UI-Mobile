import 'package:equatable/equatable.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';

class Comment extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String? photo;
  final DateTime createdAt;
  final String content;
  final int likes;
  final bool liked;
  final List<ReplyModel> replies;
  const Comment({
    required this.id,
    required this.userId,
    required this.userName,
    this.photo,
    required this.createdAt,
    required this.content,
    required this.likes,
    required this.liked,
    required this.replies,
  });

  @override
  List<Object?> get props => [id];
}
