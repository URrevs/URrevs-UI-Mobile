import 'package:urrevs_ui_mobile/domain/models/post.dart';

class CompanyReview extends Post {
  final String type;
  final String targetId;
  final String targetName;
  final String userId;
  final String userName;
  final String? photo;
  final DateTime createdAt;
  final String corresPhoneRev;
  final int views;
  final int likes;
  final int commentsCount;
  final int shares;
  final double generalRating;
  final String pros;
  final String cons;
  final bool liked;
  const CompanyReview({
    required String id,
    required this.type,
    required this.targetId,
    required this.targetName,
    required this.userId,
    required this.userName,
    required this.photo,
    required this.createdAt,
    required this.corresPhoneRev,
    required this.views,
    required this.likes,
    required this.commentsCount,
    required this.shares,
    required this.generalRating,
    required this.pros,
    required this.cons,
    required this.liked,
  }) : super(id: id);

  @override
  List<Object?> get props => [id];
}
