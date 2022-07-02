import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';

class Answer extends DirectInteraction implements Interaction {
  final String userId;
  final String userName;
  final String? photo;
  final DateTime createdAt;
  final DateTime? ownedAt;
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
  Answer copyWith({
    List<ReplyModel>? replies,
    String? userId,
    String? userName,
    String? photo,
    DateTime? createdAt,
    DateTime? ownedAt,
    String? content,
    int? upvotes,
    bool? upvoted,
    bool? accepted,
  }) {
    return Answer(
      id: id,
      replies: replies ?? this.replies,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      photo: photo ?? this.photo,
      createdAt: createdAt ?? this.createdAt,
      ownedAt: ownedAt ?? this.ownedAt,
      content: content ?? this.content,
      upvotes: upvotes ?? this.upvotes,
      upvoted: upvoted ?? this.upvoted,
      accepted: accepted ?? this.accepted,
    );
  }

  static Answer get dummyInstance => Answer(
        id: 'dummy',
        userId: 'dummy',
        userName: 'dummy',
        photo: StringsManager.picsum200x200,
        createdAt: DateTime.now(),
        ownedAt: DateTime.now(),
        content: 'dummy',
        upvotes: 1,
        upvoted: false,
        replies: [],
        accepted: false,
      );
}
