import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

class Question extends Post {
  final TargetType type;
  final String userId;
  final String userName;
  final String? photo;
  final DateTime createdAt;
  final String targetName;
  final String targetId;
  final String content;
  final int upvotes;
  final bool upvoted;
  final int ansCount;
  final int shares;
  final Answer acceptedAns;
  const Question({
    required String id,
    required this.type,
    required this.userId,
    required this.userName,
    required this.photo,
    required this.createdAt,
    required this.targetName,
    required this.targetId,
    required this.content,
    required this.upvotes,
    required this.upvoted,
    required this.ansCount,
    required this.shares,
    required this.acceptedAns,
  }) : super(id: id);

  @override
  List<Object?> get props => [id];
}
