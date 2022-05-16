import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';

class ReplyNotifier extends StateNotifier<ReplyModel> {
  ReplyNotifier({required ReplyModel? reply}) : super(reply!);

  void incrementLikes() {
    state = state.copyWith(likes: state.likes + 1);
  }

  void decrementLikes() {
    if (state.likes > 0) {
      state = state.copyWith(likes: state.likes - 1);
    }
  }
}
