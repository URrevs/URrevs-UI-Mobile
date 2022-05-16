import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';

class Question extends Post {
  final TargetType type;
  final String userId;
  final String userName;
  final String? photo;
  final DateTime createdAt;
  final String targetName;
  final String targetId;
  final String content;
  final bool upvoted;
  final int upvotes;
  final int ansCount;
  final int shares;
  final Answer? acceptedAns;
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

  Question copyWith({
    int? likes,
    TargetType? type,
    String? userId,
    String? userName,
    String? photo,
    DateTime? createdAt,
    String? targetName,
    String? targetId,
    String? content,
    bool? upvoted,
    int? upvotes,
    int? ansCount,
    int? shares,
    Answer? acceptedAns,
  }) {
    return Question(
      id: id,
      upvotes: upvotes ?? this.upvotes,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      photo: photo ?? this.photo,
      createdAt: createdAt ?? this.createdAt,
      targetName: targetName ?? this.targetName,
      targetId: targetId ?? this.targetId,
      content: content ?? this.content,
      upvoted: upvoted ?? this.upvoted,
      ansCount: ansCount ?? this.ansCount,
      shares: shares ?? this.shares,
      acceptedAns: acceptedAns ?? this.acceptedAns,
    );
  }

  static Question get dummyInstance => Question(
        id: 'dummy',
        targetId: 'dummy',
        targetName: 'dummy',
        userId: 'dummy',
        userName: 'dummy',
        photo: StringsManager.picsum200x200,
        createdAt: DateTime.now(),
        upvotes: 10,
        ansCount: 10,
        shares: 10,
        content: 'dummy',
        upvoted: false,
        acceptedAns: null,
        type: TargetType.phone,
      );
}
