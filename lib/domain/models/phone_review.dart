import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';

class PhoneReview extends Post {
  final String type;
  final String targetId;
  final String targetName;
  final String userId;
  final String userName;
  final String? photo;
  final DateTime createdAt;
  final int views;
  final int likes;
  final int commentsCount;
  final int shares;
  final DateTime ownedAt;
  final double generalRating;
  final int uiRating;
  final int manufacturingQuality;
  final int valueForMoney;
  final int camera;
  final int callQuality;
  final int battery;
  final String pros;
  final String cons;
  final bool liked;
  final double verificationRatio;
  const PhoneReview({
    required String id,
    required this.type,
    required this.targetId,
    required this.targetName,
    required this.userId,
    required this.userName,
    required this.photo,
    required this.createdAt,
    required this.views,
    required this.likes,
    required this.commentsCount,
    required this.shares,
    required this.ownedAt,
    required this.generalRating,
    required this.uiRating,
    required this.manufacturingQuality,
    required this.valueForMoney,
    required this.camera,
    required this.callQuality,
    required this.battery,
    required this.pros,
    required this.cons,
    required this.liked,
    required this.verificationRatio,
  }) : super(id: id);

  VerificationStatus get verificationStatus {
    if (verificationRatio == 0) {
      return VerificationStatus.unverified;
    } else if (verificationRatio == -1) {
      return VerificationStatus.iphone;
    } else {
      return VerificationStatus.verified;
    }
  }

  List<int> get scores {
    return [
      generalRating.toInt(),
      uiRating,
      manufacturingQuality,
      valueForMoney,
      camera,
      callQuality,
      battery,
    ];
  }

  @override
  List<Object?> get props => [id];

  PhoneReview copyWith({
    String? type,
    String? targetId,
    String? targetName,
    String? userId,
    String? userName,
    String? photo,
    DateTime? createdAt,
    int? views,
    int? likes,
    int? commentsCount,
    int? shares,
    DateTime? ownedAt,
    double? generalRating,
    int? uiRating,
    int? manufacturingQuality,
    int? valueForMoney,
    int? camera,
    int? callQuality,
    int? battery,
    String? pros,
    String? cons,
    bool? liked,
    double? verificationRatio,
  }) {
    return PhoneReview(
      id: id,
      type: type ?? this.type,
      targetId: targetId ?? this.targetId,
      targetName: targetName ?? this.targetName,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      photo: photo ?? this.photo,
      createdAt: createdAt ?? this.createdAt,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      commentsCount: commentsCount ?? this.commentsCount,
      shares: shares ?? this.shares,
      ownedAt: ownedAt ?? this.ownedAt,
      generalRating: generalRating ?? this.generalRating,
      uiRating: uiRating ?? this.uiRating,
      manufacturingQuality: manufacturingQuality ?? this.manufacturingQuality,
      valueForMoney: valueForMoney ?? this.valueForMoney,
      camera: camera ?? this.camera,
      callQuality: callQuality ?? this.callQuality,
      battery: battery ?? this.battery,
      pros: pros ?? this.pros,
      cons: cons ?? this.cons,
      liked: liked ?? this.liked,
      verificationRatio: verificationRatio ?? this.verificationRatio,
    );
  }

  static PhoneReview get dummyInstance => PhoneReview(
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
        ownedAt: DateTime.now(),
        generalRating: 3,
        uiRating: 3,
        manufacturingQuality: 3,
        valueForMoney: 3,
        camera: 3,
        callQuality: 3,
        battery: 3,
        pros: 'dummy',
        cons: 'dummy',
        liked: false,
        verificationRatio: 33.33,
      );
}
