import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';

class Answer extends DirectInteraction {
  final String userId;
  final String userName;
  final String? photo;
  final DateTime createdAt;
  final DateTime ownedAt;
  final String content;
  final int upvotes;
  final bool upvoted;
  final bool accepted;
  const Answer({
    required String id,
    required this.userId,
    required this.userName,
    required this.photo,
    required this.createdAt,
    required this.ownedAt,
    required this.content,
    required this.upvotes,
    required this.upvoted,
    required List<ReplyModel> replies,
    required this.accepted,
  }) : super(id: id, replies: replies);

  @override
  List<Object?> get props => [id, accepted];

  Answer copyWith({
    String? userId,
    String? userName,
    String? photo,
    DateTime? createdAt,
    DateTime? ownedAt,
    String? content,
    int? upvotes,
    bool? upvoted,
    bool? accepted,
    List<ReplyModel>? replies,
  }) {
    return Answer(
      id: id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      photo: photo ?? this.photo,
      createdAt: createdAt ?? this.createdAt,
      ownedAt: ownedAt ?? this.ownedAt,
      content: content ?? this.content,
      upvotes: upvotes ?? this.upvotes,
      upvoted: upvoted ?? this.upvoted,
      accepted: accepted ?? this.accepted,
      replies: replies ?? this.replies,
    );
  }
}
