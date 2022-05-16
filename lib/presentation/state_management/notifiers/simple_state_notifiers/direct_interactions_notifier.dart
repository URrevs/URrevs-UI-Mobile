import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';

class DirectInteractionNotifier extends StateNotifier<DirectInteraction> {
  DirectInteractionNotifier({required DirectInteraction? interaction})
      : super(interaction!);

  void incrementLikes() {
    final post = state;
    if (post is Comment) {
      state = post.copyWith(likes: post.likes + 1);
    } else if (post is Answer) {
      state = post.copyWith(upvotes: post.upvotes + 1);
    }
  }

  void decrementLikes() {
    final post = state;
    if (post is Comment) {
      if (post.likes > 0) state = post.copyWith(likes: post.likes - 1);
    } else if (post is Answer) {
      if (post.upvotes > 0) state = post.copyWith(upvotes: post.upvotes - 1);
    }
  }
}
