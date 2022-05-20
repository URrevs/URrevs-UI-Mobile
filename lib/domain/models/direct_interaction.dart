import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

class DirectInteraction extends Equatable {
  final String id;
  final List<ReplyModel> replies;
  const DirectInteraction({
    required this.id,
    required this.replies,
  });
  @override
  List<Object?> get props => [id];

  InteractionType get interactionType {
    switch (runtimeType) {
      case Comment:
        return InteractionType.comment;
      case Answer:
        return InteractionType.answer;
    }
    // fallback value
    return InteractionType.comment;
  }

  DirectInteraction copyWith({
    List<ReplyModel>? replies,
  }) {
    return DirectInteraction(
      id: id,
      replies: replies ?? this.replies,
    );
  }
}
