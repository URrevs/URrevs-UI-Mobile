import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';

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

  Comment copyWith({
    List<ReplyModel>? replies,
    String? userId,
    String? userName,
    String? photo,
    DateTime? createdAt,
    String? content,
    int? likes,
    bool? liked,
  }) {
    return Comment(
      id: id,
      replies: replies ?? this.replies,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      photo: photo ?? this.photo,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      liked: liked ?? this.liked,
    );
  }

  static Comment get dummyInstance => Comment(
        id: 'dummy',
        userId: 'dummy',
        userName: 'dummy',
        photo: StringsManager.picsum200x200,
        createdAt: DateTime.now(),
        content: 'dummy',
        likes: 1,
        liked: false,
        replies: [],
      );
}
