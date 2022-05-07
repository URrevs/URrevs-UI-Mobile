import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/models/search_result.dart';

class PhoneReview extends Equatable {
  final String id;
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
  const PhoneReview({
    required this.id,
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
  });

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
}
