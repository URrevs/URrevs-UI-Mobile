import 'package:equatable/equatable.dart';

class ReplyModel extends Equatable {
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
}
