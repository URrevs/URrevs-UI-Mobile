import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/info.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/models/review.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/domain/models/specs.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';

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

  User get userModel =>
      User(id: id, name: name, picture: picture, points: points);

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

  User get userModel =>
      User(id: id, name: name, picture: picture, points: points);

  factory AnotherUserSubResponse.fromJson(Map<String, Object?> json) =>
      _$AnotherUserSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AnotherUserSubResponseToJson(this);
}

@JsonSerializable()
class PhoneSubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String name;

  PhoneSubResponse({
    required this.id,
    required this.type,
    required this.name,
  });

  Phone get phoneModel => Phone(id: id, name: name);

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
  double? priceEur;
  double? priceUsd;
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

  SpecsSubResponse({
    required this.id,
    required this.name,
    required this.type,
    required this.picture,
    required this.companyId,
    required this.companyName,
    required this.priceEgp,
    required this.priceEur,
    required this.priceUsd,
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
      priceEur: priceEur,
      priceUsd: priceUsd,
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
    );
  }

  factory SpecsSubResponse.fromJson(Map<String, Object?> json) =>
      _$SpecsSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SpecsSubResponseToJson(this);
}

@JsonSerializable()
class InfoSubResponse {
  int views;
  num generalRating;
  num companyRating;
  num uiRating;
  num manufacturingQuality;
  num valueForMoney;
  num camera;
  num callQuality;
  num battery;

  InfoSubResponse({
    required this.views,
    required this.generalRating,
    required this.companyRating,
    required this.uiRating,
    required this.manufacturingQuality,
    required this.valueForMoney,
    required this.camera,
    required this.callQuality,
    required this.battery,
  });

  Info get infoModel => Info(
        views: views,
        generalRating: generalRating,
        companyRating: companyRating,
        uiRating: uiRating,
        manufacturingQuality: manufacturingQuality,
        valueForMoney: valueForMoney,
        camera: camera,
        callQuality: callQuality,
        battery: battery,
      );

  factory InfoSubResponse.fromJson(Map<String, Object?> json) =>
      _$InfoSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InfoSubResponseToJson(this);
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
class ReviewSubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String targetId;
  String targetName;
  String userId;
  String userName;
  String photo;
  @JsonKey(fromJson: _dateTimeFromTimestamp)
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

  ReviewSubResponse({
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

  PhoneReview get reviewModel => PhoneReview(
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
      );

  static DateTime _dateTimeFromTimestamp(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp);

  factory ReviewSubResponse.fromJson(Map<String, Object?> json) =>
      _$ReviewSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewSubResponseToJson(this);
}
