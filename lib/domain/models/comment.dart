import 'package:equatable/equatable.dart';
import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';

class Comment extends DirectInteraction {
  final String userId;
  final String userName;
  final String? photo;
  final DateTime createdAt;
  final String content;
  final int likes;
  final bool liked;
  const Comment({
    required String id,
    required this.userId,
    required this.userName,
    required this.photo,
    required this.createdAt,
    required this.content,
    required this.likes,
    required this.liked,
    required List<ReplyModel> replies,
  }) : super(id: id, replies: replies);

  @override
  List<Object?> get props => [id];
}
