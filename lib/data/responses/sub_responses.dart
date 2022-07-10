import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/company_stats.dart';
import 'package:urrevs_ui_mobile/domain/models/competition.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_stats.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/domain/models/specs.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

part 'sub_responses.g.dart';

@JsonSerializable()
class UserSubResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  String? picture;
  int points;
  String refCode;

  UserSubResponse({
    required this.id,
    required this.name,
    this.picture,
    required this.points,
    required this.refCode,
  });

  User get userModel => User(
        id: id,
        name: name,
        picture: picture,
        points: points,
        rank: null,
      );

  factory UserSubResponse.fromJson(Map<String, Object?> json) =>
      _$UserSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserSubResponseToJson(this);
}

@JsonSerializable()
class AnotherUserSubResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  String? picture;
  int points;

  AnotherUserSubResponse({
    required this.id,
    required this.name,
    required this.picture,
    required this.points,
  });

  User get userModel => User(
        id: id,
        name: name,
        picture: picture,
        points: points,
        rank: null,
      );

  factory AnotherUserSubResponse.fromJson(Map<String, Object?> json) =>
      _$AnotherUserSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AnotherUserSubResponseToJson(this);
}

@JsonSerializable()
class UserWithRankSubResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  String? picture;
  int points;
  int rank;

  UserWithRankSubResponse({
    required this.id,
    required this.name,
    this.picture,
    required this.points,
    required this.rank,
  });

  User get userModel => User(
        id: id,
        name: name,
        picture: picture,
        points: points,
        rank: rank,
      );

  factory UserWithRankSubResponse.fromJson(Map<String, Object?> json) =>
      _$UserWithRankSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserWithRankSubResponseToJson(this);
}

@JsonSerializable()
class PhoneSubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String name;
  double? verificationRatio;

  PhoneSubResponse({
    required this.id,
    required this.type,
    required this.name,
    required this.verificationRatio,
  });

  Phone get phoneModel => Phone(
        id: id,
        name: name,
        verificationRatio: verificationRatio,
      );

  factory PhoneSubResponse.fromJson(Map<String, Object?> json) =>
      _$PhoneSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneSubResponseToJson(this);
}

@JsonSerializable()
class CompanySubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String name;

  CompanySubResponse({
    required this.id,
    required this.type,
    required this.name,
  });

  Company get companyModel => Company(id: id, name: name);

  factory CompanySubResponse.fromJson(Map<String, Object?> json) =>
      _$CompanySubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanySubResponseToJson(this);
}

@JsonSerializable()
class RecentSearchSubResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  SearchType type;

  RecentSearchSubResponse({
    required this.id,
    required this.type,
    required this.name,
  });

  SearchResult get searchResult => SearchResult(id: id, name: name, type: type);

  factory RecentSearchSubResponse.fromJson(Map<String, Object?> json) =>
      _$RecentSearchSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecentSearchSubResponseToJson(this);
}

@JsonSerializable()
class CompanyWithLogoSubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String name;
  String? logo;

  CompanyWithLogoSubResponse({
    required this.id,
    required this.type,
    required this.name,
    this.logo,
  });

  Company get companyModel => Company(id: id, name: name, logo: logo);

  factory CompanyWithLogoSubResponse.fromJson(Map<String, Object?> json) =>
      _$CompanyWithLogoSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyWithLogoSubResponseToJson(this);
}

@JsonSerializable()
class PhoneWithCompanyLogogSubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String name;
  String? companyLogo;

  PhoneWithCompanyLogogSubResponse({
    required this.id,
    required this.type,
    required this.name,
    required this.companyLogo,
  });

  Phone get phoneModel => Phone(id: id, name: name, companyLogo: companyLogo);

  factory PhoneWithCompanyLogogSubResponse.fromJson(
          Map<String, Object?> json) =>
      _$PhoneWithCompanyLogogSubResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$PhoneWithCompanyLogogSubResponseToJson(this);
}

@JsonSerializable()
class SpecsSubResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  String type;
  String picture;
  String companyId;
  String companyName;
  double? priceEgp;
  // double? priceEur;
  // double? priceUsd;
  String? releaseDate;
  String? dimensions;
  String? network;
  String? screenProtection;
  String? os;
  String? chipset;
  String? cpu;
  String? gpu;
  String? externalMem;
  String? internalMem;
  String? mainCam;
  String? selfieCam;
  String? loudspeaker;
  @JsonKey(name: 'slot3.5mm')
  String? slot3_5mm;
  String? wlan;
  String? bluetooth;
  String? gps;
  String? nfc;
  String? radio;
  String? usb;
  String? sensors;
  String? battery;
  String? charging;
  String? weight;
  String? sim;
  String? screenType;
  String? screenSize;
  String? screenResolution;

  SpecsSubResponse({
    required this.id,
    required this.name,
    required this.type,
    required this.picture,
    required this.companyId,
    required this.companyName,
    required this.priceEgp,
    // required this.priceEur,
    // required this.priceUsd,
    required this.releaseDate,
    required this.dimensions,
    required this.network,
    required this.screenProtection,
    required this.os,
    required this.chipset,
    required this.cpu,
    required this.gpu,
    required this.externalMem,
    required this.internalMem,
    required this.mainCam,
    required this.selfieCam,
    required this.loudspeaker,
    required this.slot3_5mm,
    required this.wlan,
    required this.bluetooth,
    required this.gps,
    required this.nfc,
    required this.radio,
    required this.usb,
    required this.sensors,
    required this.battery,
    required this.charging,
    required this.weight,
    required this.sim,
    required this.screenType,
    required this.screenSize,
    required this.screenResolution,
  });

  Specs get specsModel {
    return Specs(
      id: id,
      name: name,
      type: type,
      picture: picture,
      companyId: companyId,
      companyName: companyName,
      priceEgp: priceEgp,
      // priceEur: priceEur,
      // priceUsd: priceUsd,
      releaseDate: releaseDate,
      dimensions: dimensions,
      network: network,
      screenProtection: screenProtection,
      os: os,
      chipset: chipset,
      cpu: cpu,
      gpu: gpu,
      externalMem: externalMem,
      internalMem: internalMem,
      mainCam: mainCam,
      selfieCam: selfieCam,
      loudspeaker: loudspeaker,
      slot3_5mm: slot3_5mm,
      wlan: wlan,
      bluetooth: bluetooth,
      gps: gps,
      nfc: nfc,
      radio: radio,
      usb: usb,
      sensors: sensors,
      battery: battery,
      charging: charging,
      productWeight: weight,
      simCard: sim,
      displayType: screenType,
      displaySize: screenSize,
      displayResolution: screenResolution,
    );
  }

  factory SpecsSubResponse.fromJson(Map<String, Object?> json) =>
      _$SpecsSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SpecsSubResponseToJson(this);
}

@JsonSerializable()
class PhoneStatsSubResponse {
  int views;
  num generalRating;
  num companyRating;
  num uiRating;
  num manufacturingQuality;
  num valueForMoney;
  num camera;
  num callQuality;
  num battery;
  bool owned;
  double verificationRatio;

  PhoneStatsSubResponse({
    required this.views,
    required this.generalRating,
    required this.companyRating,
    required this.uiRating,
    required this.manufacturingQuality,
    required this.valueForMoney,
    required this.camera,
    required this.callQuality,
    required this.battery,
    required this.owned,
    required this.verificationRatio,
  });

  PhoneStats get phoneStatsModel => PhoneStats(
        views: views,
        generalRating: generalRating.toDouble(),
        companyRating: companyRating.toDouble(),
        uiRating: uiRating.toInt(),
        manufacturingQuality: manufacturingQuality.toInt(),
        valueForMoney: valueForMoney.toInt(),
        camera: camera.toInt(),
        callQuality: callQuality.toInt(),
        battery: battery.toInt(),
        owned: owned,
        verificationRatio: verificationRatio,
      );

  factory PhoneStatsSubResponse.fromJson(Map<String, Object?> json) =>
      _$PhoneStatsSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneStatsSubResponseToJson(this);
}

@JsonSerializable()
class CompanyStatsSubResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  int views;
  double rating;
  String type;

  CompanyStatsSubResponse({
    required this.id,
    required this.name,
    required this.views,
    required this.rating,
    required this.type,
  });

  CompanyStats get companyStatsModel => CompanyStats(
        id: id,
        name: name,
        views: views,
        rating: rating,
        type: type,
      );

  factory CompanyStatsSubResponse.fromJson(Map<String, Object?> json) =>
      _$CompanyStatsSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyStatsSubResponseToJson(this);
}

@JsonSerializable()
class PhoneWithPictureSubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String name;
  String picture;

  PhoneWithPictureSubResponse({
    required this.id,
    required this.type,
    required this.name,
    required this.picture,
  });

  Phone get phoneModel => Phone(id: id, name: name, picture: picture);

  factory PhoneWithPictureSubResponse.fromJson(Map<String, Object?> json) =>
      _$PhoneWithPictureSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneWithPictureSubResponseToJson(this);
}

@JsonSerializable()
class PhoneReviewSubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String targetId;
  String targetName;
  String userId;
  String userName;
  @JsonKey(name: 'picture')
  String? photo;
  DateTime createdAt;
  int views;
  int likes;
  int commentsCount;
  int shares;
  DateTime ownedAt;
  double generalRating;
  int uiRating;
  int manufacturingQuality;
  int valueForMoney;
  int camera;
  int callQuality;
  int battery;
  String pros;
  String cons;
  bool liked;
  double verificationRatio;

  PhoneReviewSubResponse({
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
    required this.verificationRatio,
  });

  PhoneReview get phoneReviewModel => PhoneReview(
        id: id,
        type: type,
        targetId: targetId,
        targetName: targetName,
        userId: userId,
        userName: userName,
        photo: photo,
        createdAt: createdAt,
        views: views,
        likes: likes,
        commentsCount: commentsCount,
        shares: shares,
        ownedAt: ownedAt,
        generalRating: generalRating,
        uiRating: uiRating,
        manufacturingQuality: manufacturingQuality,
        valueForMoney: valueForMoney,
        camera: camera,
        callQuality: callQuality,
        battery: battery,
        pros: pros,
        cons: cons,
        liked: liked,
        verificationRatio: verificationRatio,
      );

  factory PhoneReviewSubResponse.fromJson(Map<String, Object?> json) =>
      _$PhoneReviewSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneReviewSubResponseToJson(this);
}

@JsonSerializable()
class PhoneReviewForAddPhoneReviewSubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String phoneId;
  String phoneName;
  String userId;
  String userName;
  @JsonKey(name: 'picture')
  String? photo;
  DateTime createdAt;
  DateTime ownedAt;
  int views;
  int likes;
  int commentsCount;
  int shares;
  double generalRating;
  int uiRating;
  int manufacturingQuality;
  int valueForMoney;
  int camera;
  int callQuality;
  int battery;
  String pros;
  String cons;
  double verificationRatio;

  PhoneReviewForAddPhoneReviewSubResponse({
    required this.id,
    required this.type,
    required this.phoneId,
    required this.phoneName,
    required this.userId,
    required this.userName,
    required this.photo,
    required this.createdAt,
    required this.ownedAt,
    required this.views,
    required this.likes,
    required this.commentsCount,
    required this.shares,
    required this.generalRating,
    required this.uiRating,
    required this.manufacturingQuality,
    required this.valueForMoney,
    required this.camera,
    required this.callQuality,
    required this.battery,
    required this.pros,
    required this.cons,
    required this.verificationRatio,
  });

  PhoneReview get phoneReviewModel => PhoneReview(
        id: id,
        type: type,
        targetId: phoneId,
        targetName: phoneName,
        userId: userId,
        userName: userName,
        photo: photo,
        createdAt: createdAt,
        views: views,
        likes: likes,
        commentsCount: commentsCount,
        shares: shares,
        ownedAt: ownedAt,
        generalRating: generalRating,
        uiRating: uiRating,
        manufacturingQuality: manufacturingQuality,
        valueForMoney: valueForMoney,
        camera: camera,
        callQuality: callQuality,
        battery: battery,
        pros: pros,
        cons: cons,
        liked: false,
        verificationRatio: verificationRatio,
      );

  factory PhoneReviewForAddPhoneReviewSubResponse.fromJson(
          Map<String, Object?> json) =>
      _$PhoneReviewForAddPhoneReviewSubResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$PhoneReviewForAddPhoneReviewSubResponseToJson(this);
}

@JsonSerializable()
class CompanyReviewSubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String targetId;
  String targetName;
  String userId;
  String userName;
  @JsonKey(name: 'picture')
  String? photo;
  DateTime createdAt;
  String corresPhoneRev;
  int views;
  int likes;
  int commentsCount;
  int shares;
  double generalRating;
  String pros;
  String cons;
  bool liked;
  double verificationRatio;

  CompanyReviewSubResponse({
    required this.id,
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
    required this.verificationRatio,
  });

  CompanyReview get companyReviewModel => CompanyReview(
        id: id,
        type: type,
        targetId: targetId,
        targetName: targetName,
        userId: userId,
        userName: userName,
        photo: photo,
        createdAt: createdAt,
        corresPhoneRev: corresPhoneRev,
        views: views,
        likes: likes,
        commentsCount: commentsCount,
        shares: shares,
        generalRating: generalRating,
        pros: pros,
        cons: cons,
        liked: liked,
        verificationRatio: verificationRatio,
      );

  factory CompanyReviewSubResponse.fromJson(Map<String, Object?> json) =>
      _$CompanyReviewSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyReviewSubResponseToJson(this);
}

@JsonSerializable()
class ReplySubResponse {
  @JsonKey(name: '_id')
  String id;
  String userId;
  String userName;
  @JsonKey(name: 'userPicture')
  String? photo;
  DateTime createdAt;
  String content;
  int likes;
  bool liked;
  ReplySubResponse({
    required this.id,
    required this.userId,
    required this.userName,
    this.photo,
    required this.createdAt,
    required this.content,
    required this.likes,
    required this.liked,
  });

  ReplyModel get replyModel => ReplyModel(
        id: id,
        userId: userId,
        userName: userName,
        createdAt: createdAt,
        content: content,
        likes: likes,
        liked: liked,
        photo: photo,
      );

  factory ReplySubResponse.fromJson(Map<String, Object?> json) =>
      _$ReplySubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReplySubResponseToJson(this);
}

@JsonSerializable()
class CommentSubResponse {
  @JsonKey(name: '_id')
  String id;
  String userId;
  String userName;
  @JsonKey(name: 'userPicture')
  String? photo;
  DateTime createdAt;
  String content;
  int likes;
  bool liked;
  @JsonKey(name: 'replies')
  List<ReplySubResponse>? repliesSubResponses;
  CommentSubResponse({
    required this.id,
    required this.userId,
    required this.userName,
    this.photo,
    required this.createdAt,
    required this.content,
    required this.likes,
    required this.liked,
    required this.repliesSubResponses,
  });

  Comment get commentModel => Comment(
        id: id,
        userId: userId,
        userName: userName,
        createdAt: createdAt,
        content: content,
        likes: likes,
        liked: liked,
        photo: photo,
        replies: repliesSubResponses?.map((r) => r.replyModel).toList() ?? [],
      );

  factory CommentSubResponse.fromJson(Map<String, Object?> json) =>
      _$CommentSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommentSubResponseToJson(this);
}

@JsonSerializable()
class QuestionSubResponse {
  @JsonKey(name: '_id')
  String id;
  TargetType type;
  String userId;
  String userName;
  @JsonKey(name: 'picture')
  String? photo;
  DateTime createdAt;
  String targetName;
  String targetId;
  String content;
  int upvotes;
  bool? upvoted;
  int ansCount;
  int shares;
  AnswerSubResponse? acceptedAns;
  QuestionSubResponse({
    required this.id,
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
  });

  Question get questionModel => Question(
        id: id,
        type: type,
        userId: userId,
        userName: userName,
        photo: photo,
        createdAt: createdAt,
        content: content,
        targetName: targetName,
        targetId: targetId,
        upvotes: upvotes,
        upvoted: upvoted ?? false,
        ansCount: ansCount,
        shares: shares,
        acceptedAns: acceptedAns?.answerModel(accepted: true),
      );

  factory QuestionSubResponse.fromJson(Map<String, Object?> json) =>
      _$QuestionSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionSubResponseToJson(this);
}

@JsonSerializable()
class PhoneQuestionSubResponse {
  @JsonKey(name: '_id')
  String id;
  TargetType type;
  String userId;
  String userName;
  @JsonKey(name: 'picture')
  String? photo;
  DateTime createdAt;
  String phoneName;
  String phoneId;
  String content;
  int upvotes;
  bool? upvoted;
  int ansCount;
  int shares;
  AnswerSubResponse? acceptedAns;
  PhoneQuestionSubResponse({
    required this.id,
    required this.type,
    required this.userId,
    required this.userName,
    required this.photo,
    required this.createdAt,
    required this.phoneName,
    required this.phoneId,
    required this.content,
    required this.upvotes,
    required this.upvoted,
    required this.ansCount,
    required this.shares,
    required this.acceptedAns,
  });

  Question get questionModel => Question(
        id: id,
        type: type,
        userId: userId,
        userName: userName,
        photo: photo,
        createdAt: createdAt,
        content: content,
        targetName: phoneName,
        targetId: phoneId,
        upvotes: upvotes,
        upvoted: upvoted ?? false,
        ansCount: ansCount,
        shares: shares,
        acceptedAns: acceptedAns?.answerModel(accepted: true),
      );

  factory PhoneQuestionSubResponse.fromJson(Map<String, Object?> json) =>
      _$PhoneQuestionSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneQuestionSubResponseToJson(this);
}

@JsonSerializable()
class CompanyQuestionSubResponse {
  @JsonKey(name: '_id')
  String id;
  TargetType type;
  String userId;
  String userName;
  @JsonKey(name: 'picture')
  String? photo;
  DateTime createdAt;
  String companyName;
  String companyId;
  String content;
  int upvotes;
  bool? upvoted;
  int ansCount;
  int shares;
  AnswerSubResponse? acceptedAns;
  CompanyQuestionSubResponse({
    required this.id,
    required this.type,
    required this.userId,
    required this.userName,
    required this.photo,
    required this.createdAt,
    required this.companyName,
    required this.companyId,
    required this.content,
    required this.upvotes,
    required this.upvoted,
    required this.ansCount,
    required this.shares,
    required this.acceptedAns,
  });

  Question get questionModel => Question(
        id: id,
        type: type,
        userId: userId,
        userName: userName,
        photo: photo,
        createdAt: createdAt,
        content: content,
        targetName: companyName,
        targetId: companyId,
        upvotes: upvotes,
        upvoted: upvoted ?? false,
        ansCount: ansCount,
        shares: shares,
        acceptedAns: acceptedAns?.answerModel(accepted: true),
      );

  factory CompanyQuestionSubResponse.fromJson(Map<String, Object?> json) =>
      _$CompanyQuestionSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyQuestionSubResponseToJson(this);
}

@JsonSerializable()
class AnswerSubResponse {
  @JsonKey(name: '_id')
  String id;
  String userId;
  String userName;
  @JsonKey(name: 'picture')
  String? photo;
  DateTime createdAt;
  DateTime? ownedAt;
  String content;
  int upvotes;
  bool upvoted;
  @JsonKey(name: 'replies')
  List<ReplySubResponse>? repliesSubResponses;
  AnswerSubResponse({
    required this.id,
    required this.userId,
    required this.userName,
    required this.photo,
    required this.createdAt,
    required this.ownedAt,
    required this.content,
    required this.upvotes,
    required this.upvoted,
    required this.repliesSubResponses,
  });

  Answer answerModel({required bool accepted}) => Answer(
        id: id,
        userId: userId,
        userName: userName,
        createdAt: createdAt,
        ownedAt: ownedAt,
        photo: photo,
        content: content,
        upvotes: upvotes,
        upvoted: upvoted,
        replies: repliesSubResponses?.map((r) => r.replyModel).toList() ?? [],
        accepted: accepted,
      );

  factory AnswerSubResponse.fromJson(Map<String, Object?> json) =>
      _$AnswerSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerSubResponseToJson(this);
}

@JsonSerializable()
class CompetitionSubResponse {
  @JsonKey(name: '_id')
  String id;
  DateTime deadline;
  int numWinners;
  String prize;
  String prizePic;
  DateTime createdAt;
  CompetitionSubResponse({
    required this.id,
    required this.deadline,
    required this.numWinners,
    required this.prize,
    required this.prizePic,
    required this.createdAt,
  });

  Competition get competitionModel => Competition(
        id: id,
        deadline: deadline,
        numWinners: numWinners,
        prize: prize,
        prizePic: prizePic,
        createdAt: createdAt,
      );

  factory CompetitionSubResponse.fromJson(Map<String, Object?> json) =>
      _$CompetitionSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompetitionSubResponseToJson(this);
}

@JsonSerializable()
class ReportSubResponse {
  @JsonKey(name: '_id')
  String id;
  ReportType type;
  DateTime createdAt;
  @JsonKey(fromJson: _intToComplaintReason, toJson: _complaintReasonToInt)
  ComplaintReason reason;
  String? info;
  String reporterId;
  String reporterName;
  String? reporterPicture;
  String reporteeId;
  String reporteeName;
  @JsonKey(name: 'phoneRev')
  String? phoneReviewSubResponse;
  @JsonKey(name: 'companyRev')
  String? companyReviewSubResponse;
  @JsonKey(name: 'phoneQues')
  String? phoneQuestionSubResponse;
  @JsonKey(name: 'companyQues')
  String? companyQuestionSubResponse;
  @JsonKey(name: 'phoneComment')
  String? phoneCommentSubResponse;
  @JsonKey(name: 'companyComment')
  String? companyCommentSubResponse;
  @JsonKey(name: 'phoneAnswer')
  String? phoneAnswerSubResponse;
  @JsonKey(name: 'companyAnswer')
  String? companyAnswerSubResponse;
  @JsonKey(name: 'phoneCommentReply')
  String? phoneCommentReplySubResponse;
  @JsonKey(name: 'companyCommentReply')
  String? companyCommentReplySubResponse;
  @JsonKey(name: 'phoneAnswerReply')
  String? phoneAnswerReplySubResponse;
  @JsonKey(name: 'companyAnswerReply')
  String? companyAnswerReplySubResponse;
  bool reporteeBlocked;
  bool contentHidden;
  ReportSubResponse({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.reason,
    this.info,
    required this.reporterId,
    required this.reporterName,
    this.reporterPicture,
    required this.reporteeId,
    required this.reporteeName,
    this.phoneReviewSubResponse,
    this.companyReviewSubResponse,
    this.phoneQuestionSubResponse,
    this.companyQuestionSubResponse,
    this.phoneCommentSubResponse,
    this.companyCommentSubResponse,
    this.phoneAnswerSubResponse,
    this.companyAnswerSubResponse,
    this.phoneCommentReplySubResponse,
    this.companyCommentReplySubResponse,
    this.phoneAnswerReplySubResponse,
    this.companyAnswerReplySubResponse,
    required this.reporteeBlocked,
    required this.contentHidden,
  });

  static ComplaintReason _intToComplaintReason(int reasonNum) =>
      ComplaintReason.values[reasonNum - 1];
  static int _complaintReasonToInt(ComplaintReason reason) => reason.index + 1;

  Report get reportModel => Report(
        id: id,
        type: type,
        createdAt: createdAt,
        reason: reason,
        info: info,
        reporterId: reporterId,
        reporterName: reporterName,
        reporterPicture: reporterPicture,
        reporteeId: reporteeId,
        reporteeName: reporteeName,
        phoneReview: phoneReviewSubResponse,
        companyReview: companyReviewSubResponse,
        question: phoneQuestionSubResponse ?? companyQuestionSubResponse,
        comment: phoneCommentSubResponse ?? companyCommentSubResponse,
        answer: phoneAnswerSubResponse ?? companyAnswerSubResponse,
        reply: phoneCommentReplySubResponse ??
            companyCommentReplySubResponse ??
            phoneAnswerReplySubResponse ??
            companyAnswerReplySubResponse,
        reporteeBlocked: reporteeBlocked,
        contentHidden: contentHidden,
      );

  factory ReportSubResponse.fromJson(Map<String, Object?> json) =>
      _$ReportSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReportSubResponseToJson(this);
}
