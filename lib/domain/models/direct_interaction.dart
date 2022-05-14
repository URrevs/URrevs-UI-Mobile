import 'package:equatable/equatable.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';

class DirectInteraction extends Equatable {
  final String id;
  final List<ReplyModel> replies;
  const DirectInteraction({
    required this.id,
    required this.replies,
  });
  @override
  List<Object?> get props => [id];
}
