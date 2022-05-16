import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';

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

  CompanyReview copyWith({
    String? type,
    String? targetId,
    String? targetName,
    String? userId,
    String? userName,
    String? photo,
    DateTime? createdAt,
    String? corresPhoneRev,
    int? views,
    int? likes,
    int? commentsCount,
    int? shares,
    double? generalRating,
    String? pros,
    String? cons,
    bool? liked,
  }) {
    return CompanyReview(
      id: id,
      type: type ?? this.type,
      targetId: targetId ?? this.targetId,
      targetName: targetName ?? this.targetName,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      photo: photo ?? this.photo,
      createdAt: createdAt ?? this.createdAt,
      corresPhoneRev: corresPhoneRev ?? this.corresPhoneRev,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      commentsCount: commentsCount ?? this.commentsCount,
      shares: shares ?? this.shares,
      generalRating: generalRating ?? this.generalRating,
      pros: pros ?? this.pros,
      cons: cons ?? this.cons,
      liked: liked ?? this.liked,
    );
  }

  static CompanyReview get dummyInstance => CompanyReview(
        id: 'dummy',
        type: 'phone',
        targetId: 'dummy',
        targetName: 'dummy',
        userId: 'dummy',
        userName: 'dummy',
        photo: StringsManager.picsum200x200,
        createdAt: DateTime.now(),
        views: 10,
        likes: 10,
        commentsCount: 10,
        shares: 10,
        generalRating: 3,
        pros: 'dummy',
        cons: 'dummy',
        liked: false,
        corresPhoneRev: 'dummy',
      );
}
