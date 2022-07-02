import 'package:equatable/equatable.dart';
import 'package:urrevs_ui_mobile/domain/models/interaction.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';

class ReplyModel extends Equatable implements Interaction {
  final String id;
  final String userId;
  final String userName;
  final String? photo;
  final DateTime createdAt;
  final String content;
  final int likes;
  final bool liked;
  const ReplyModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.photo,
    required this.createdAt,
    required this.content,
    required this.likes,
    required this.liked,
  });

  @override
  List<Object?> get props => [id];

  ReplyModel copyWith({
    String? userId,
    String? userName,
    String? photo,
    DateTime? createdAt,
    String? content,
    int? likes,
    bool? liked,
  }) {
    return ReplyModel(
      id: id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      photo: photo ?? this.photo,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      liked: liked ?? this.liked,
    );
  }

  static ReplyModel get dummyInstance => ReplyModel(
        id: 'dummy',
        userId: 'dummy',
        userName: 'dummy',
        photo: StringsManager.picsum200x200,
        createdAt: DateTime.now(),
        content: 'dummy',
        likes: 1,
        liked: false,
      );


}
