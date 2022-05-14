// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSubResponse _$UserSubResponseFromJson(Map<String, dynamic> json) =>
    UserSubResponse(
      id: json['_id'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String?,
      points: json['points'] as int,
      refCode: json['refCode'] as String,
    );

Map<String, dynamic> _$UserSubResponseToJson(UserSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
      'points': instance.points,
      'refCode': instance.refCode,
    };

AnotherUserSubResponse _$AnotherUserSubResponseFromJson(
        Map<String, dynamic> json) =>
    AnotherUserSubResponse(
      id: json['_id'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String?,
      points: json['points'] as int,
    );

Map<String, dynamic> _$AnotherUserSubResponseToJson(
        AnotherUserSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
      'points': instance.points,
    };

PhoneSubResponse _$PhoneSubResponseFromJson(Map<String, dynamic> json) =>
    PhoneSubResponse(
      id: json['_id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PhoneSubResponseToJson(PhoneSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'name': instance.name,
    };

CompanySubResponse _$CompanySubResponseFromJson(Map<String, dynamic> json) =>
    CompanySubResponse(
      id: json['_id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CompanySubResponseToJson(CompanySubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'name': instance.name,
    };

RecentSearchSubResponse _$RecentSearchSubResponseFromJson(
        Map<String, dynamic> json) =>
    RecentSearchSubResponse(
      id: json['_id'] as String,
      type: $enumDecode(_$SearchTypeEnumMap, json['type']),
      name: json['name'] as String,
    );

Map<String, dynamic> _$RecentSearchSubResponseToJson(
        RecentSearchSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'type': _$SearchTypeEnumMap[instance.type],
    };

const _$SearchTypeEnumMap = {
  SearchType.phone: 'phone',
  SearchType.company: 'company',
};

CompanyWithLogoSubResponse _$CompanyWithLogoSubResponseFromJson(
        Map<String, dynamic> json) =>
    CompanyWithLogoSubResponse(
      id: json['_id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String?,
    );

Map<String, dynamic> _$CompanyWithLogoSubResponseToJson(
        CompanyWithLogoSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'logo': instance.logo,
    };

PhoneWithCompanyLogogSubResponse _$PhoneWithCompanyLogogSubResponseFromJson(
        Map<String, dynamic> json) =>
    PhoneWithCompanyLogogSubResponse(
      id: json['_id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      companyLogo: json['companyLogo'] as String?,
    );

Map<String, dynamic> _$PhoneWithCompanyLogogSubResponseToJson(
        PhoneWithCompanyLogogSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'companyLogo': instance.companyLogo,
    };

SpecsSubResponse _$SpecsSubResponseFromJson(Map<String, dynamic> json) =>
    SpecsSubResponse(
      id: json['_id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      picture: json['picture'] as String,
      companyId: json['companyId'] as String,
      companyName: json['companyName'] as String,
      priceEgp: (json['priceEgp'] as num?)?.toDouble(),
      priceEur: (json['priceEur'] as num?)?.toDouble(),
      priceUsd: (json['priceUsd'] as num?)?.toDouble(),
      releaseDate: json['releaseDate'] as String?,
      dimensions: json['dimensions'] as String?,
      network: json['network'] as String?,
      screenProtection: json['screenProtection'] as String?,
      os: json['os'] as String?,
      chipset: json['chipset'] as String?,
      cpu: json['cpu'] as String?,
      gpu: json['gpu'] as String?,
      externalMem: json['externalMem'] as String?,
      internalMem: json['internalMem'] as String?,
      mainCam: json['mainCam'] as String?,
      selfieCam: json['selfieCam'] as String?,
      loudspeaker: json['loudspeaker'] as String?,
      slot3_5mm: json['slot3.5mm'] as String?,
      wlan: json['wlan'] as String?,
      bluetooth: json['bluetooth'] as String?,
      gps: json['gps'] as String?,
      nfc: json['nfc'] as String?,
      radio: json['radio'] as String?,
      usb: json['usb'] as String?,
      sensors: json['sensors'] as String?,
      battery: json['battery'] as String?,
      charging: json['charging'] as String?,
    );

Map<String, dynamic> _$SpecsSubResponseToJson(SpecsSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'picture': instance.picture,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'priceEgp': instance.priceEgp,
      'priceEur': instance.priceEur,
      'priceUsd': instance.priceUsd,
      'releaseDate': instance.releaseDate,
      'dimensions': instance.dimensions,
      'network': instance.network,
      'screenProtection': instance.screenProtection,
      'os': instance.os,
      'chipset': instance.chipset,
      'cpu': instance.cpu,
      'gpu': instance.gpu,
      'externalMem': instance.externalMem,
      'internalMem': instance.internalMem,
      'mainCam': instance.mainCam,
      'selfieCam': instance.selfieCam,
      'loudspeaker': instance.loudspeaker,
      'slot3.5mm': instance.slot3_5mm,
      'wlan': instance.wlan,
      'bluetooth': instance.bluetooth,
      'gps': instance.gps,
      'nfc': instance.nfc,
      'radio': instance.radio,
      'usb': instance.usb,
      'sensors': instance.sensors,
      'battery': instance.battery,
      'charging': instance.charging,
    };

InfoSubResponse _$InfoSubResponseFromJson(Map<String, dynamic> json) =>
    InfoSubResponse(
      views: json['views'] as int,
      generalRating: json['generalRating'] as num,
      companyRating: json['companyRating'] as num,
      uiRating: json['uiRating'] as num,
      manufacturingQuality: json['manufacturingQuality'] as num,
      valueForMoney: json['valueForMoney'] as num,
      camera: json['camera'] as num,
      callQuality: json['callQuality'] as num,
      battery: json['battery'] as num,
    );

Map<String, dynamic> _$InfoSubResponseToJson(InfoSubResponse instance) =>
    <String, dynamic>{
      'views': instance.views,
      'generalRating': instance.generalRating,
      'companyRating': instance.companyRating,
      'uiRating': instance.uiRating,
      'manufacturingQuality': instance.manufacturingQuality,
      'valueForMoney': instance.valueForMoney,
      'camera': instance.camera,
      'callQuality': instance.callQuality,
      'battery': instance.battery,
    };

PhoneWithPictureSubResponse _$PhoneWithPictureSubResponseFromJson(
        Map<String, dynamic> json) =>
    PhoneWithPictureSubResponse(
      id: json['_id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String,
    );

Map<String, dynamic> _$PhoneWithPictureSubResponseToJson(
        PhoneWithPictureSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'picture': instance.picture,
    };

PhoneReviewSubResponse _$PhoneReviewSubResponseFromJson(
        Map<String, dynamic> json) =>
    PhoneReviewSubResponse(
      id: json['_id'] as String,
      type: json['type'] as String,
      targetId: json['targetId'] as String,
      targetName: json['targetName'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      photo: json['photo'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      views: json['views'] as int,
      likes: json['likes'] as int,
      commentsCount: json['commentsCount'] as int,
      shares: json['shares'] as int,
      ownedAt: DateTime.parse(json['ownedAt'] as String),
      generalRating: (json['generalRating'] as num).toDouble(),
      uiRating: json['uiRating'] as int,
      manufacturingQuality: json['manufacturingQuality'] as int,
      valueForMoney: json['valueForMoney'] as int,
      camera: json['camera'] as int,
      callQuality: json['callQuality'] as int,
      battery: json['battery'] as int,
      pros: json['pros'] as String,
      cons: json['cons'] as String,
      liked: json['liked'] as bool,
    );

Map<String, dynamic> _$PhoneReviewSubResponseToJson(
        PhoneReviewSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'targetId': instance.targetId,
      'targetName': instance.targetName,
      'userId': instance.userId,
      'userName': instance.userName,
      'photo': instance.photo,
      'createdAt': instance.createdAt.toIso8601String(),
      'views': instance.views,
      'likes': instance.likes,
      'commentsCount': instance.commentsCount,
      'shares': instance.shares,
      'ownedAt': instance.ownedAt.toIso8601String(),
      'generalRating': instance.generalRating,
      'uiRating': instance.uiRating,
      'manufacturingQuality': instance.manufacturingQuality,
      'valueForMoney': instance.valueForMoney,
      'camera': instance.camera,
      'callQuality': instance.callQuality,
      'battery': instance.battery,
      'pros': instance.pros,
      'cons': instance.cons,
      'liked': instance.liked,
    };

PhoneReviewForAddPhoneReviewSubResponse
    _$PhoneReviewForAddPhoneReviewSubResponseFromJson(
            Map<String, dynamic> json) =>
        PhoneReviewForAddPhoneReviewSubResponse(
          id: json['_id'] as String,
          type: json['type'] as String,
          phoneId: json['phoneId'] as String,
          phoneName: json['phoneName'] as String,
          userId: json['userId'] as String,
          userName: json['userName'] as String,
          photo: json['picture'] as String?,
          createdAt: DateTime.parse(json['createdAt'] as String),
          ownedAt: DateTime.parse(json['ownedAt'] as String),
          views: json['views'] as int,
          likes: json['likes'] as int,
          commentsCount: json['commentsCount'] as int,
          shares: json['shares'] as int,
          generalRating: (json['generalRating'] as num).toDouble(),
          uiRating: json['uiRating'] as int,
          manufacturingQuality: json['manufacturingQuality'] as int,
          valueForMoney: json['valueForMoney'] as int,
          camera: json['camera'] as int,
          callQuality: json['callQuality'] as int,
          battery: json['battery'] as int,
          pros: json['pros'] as String,
          cons: json['cons'] as String,
        );

Map<String, dynamic> _$PhoneReviewForAddPhoneReviewSubResponseToJson(
        PhoneReviewForAddPhoneReviewSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'phoneId': instance.phoneId,
      'phoneName': instance.phoneName,
      'userId': instance.userId,
      'userName': instance.userName,
      'picture': instance.photo,
      'createdAt': instance.createdAt.toIso8601String(),
      'ownedAt': instance.ownedAt.toIso8601String(),
      'views': instance.views,
      'likes': instance.likes,
      'commentsCount': instance.commentsCount,
      'shares': instance.shares,
      'generalRating': instance.generalRating,
      'uiRating': instance.uiRating,
      'manufacturingQuality': instance.manufacturingQuality,
      'valueForMoney': instance.valueForMoney,
      'camera': instance.camera,
      'callQuality': instance.callQuality,
      'battery': instance.battery,
      'pros': instance.pros,
      'cons': instance.cons,
    };

CompanyReviewSubResponse _$CompanyReviewSubResponseFromJson(
        Map<String, dynamic> json) =>
    CompanyReviewSubResponse(
      id: json['_id'] as String,
      type: json['type'] as String,
      targetId: json['targetId'] as String,
      targetName: json['targetName'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      photo: json['picture'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      corresPhoneRev: json['corresPhoneRev'] as String,
      views: json['views'] as int,
      likes: json['likes'] as int,
      commentsCount: json['commentsCount'] as int,
      shares: json['shares'] as int,
      generalRating: (json['generalRating'] as num).toDouble(),
      pros: json['pros'] as String,
      cons: json['cons'] as String,
      liked: json['liked'] as bool,
    );

Map<String, dynamic> _$CompanyReviewSubResponseToJson(
        CompanyReviewSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'targetId': instance.targetId,
      'targetName': instance.targetName,
      'userId': instance.userId,
      'userName': instance.userName,
      'picture': instance.photo,
      'createdAt': instance.createdAt.toIso8601String(),
      'corresPhoneRev': instance.corresPhoneRev,
      'views': instance.views,
      'likes': instance.likes,
      'commentsCount': instance.commentsCount,
      'shares': instance.shares,
      'generalRating': instance.generalRating,
      'pros': instance.pros,
      'cons': instance.cons,
      'liked': instance.liked,
    };

ReplySubResponse _$ReplySubResponseFromJson(Map<String, dynamic> json) =>
    ReplySubResponse(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      photo: json['userPicture'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      content: json['content'] as String,
      likes: json['likes'] as int,
      liked: json['liked'] as bool,
    );

Map<String, dynamic> _$ReplySubResponseToJson(ReplySubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userPicture': instance.photo,
      'createdAt': instance.createdAt.toIso8601String(),
      'content': instance.content,
      'likes': instance.likes,
      'liked': instance.liked,
    };

CommentSubResponse _$CommentSubResponseFromJson(Map<String, dynamic> json) =>
    CommentSubResponse(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      photo: json['userPicture'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      content: json['content'] as String,
      likes: json['likes'] as int,
      liked: json['liked'] as bool,
      repliesSubResponses: (json['replies'] as List<dynamic>)
          .map((e) => ReplySubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentSubResponseToJson(CommentSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userPicture': instance.photo,
      'createdAt': instance.createdAt.toIso8601String(),
      'content': instance.content,
      'likes': instance.likes,
      'liked': instance.liked,
      'replies': instance.repliesSubResponses,
    };

QuestionSubResponse _$QuestionSubResponseFromJson(Map<String, dynamic> json) =>
    QuestionSubResponse(
      id: json['_id'] as String,
      type: $enumDecode(_$TargetTypeEnumMap, json['type']),
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      photo: json['photo'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      targetName: json['targetName'] as String,
      targetId: json['targetId'] as String,
      content: json['content'] as String,
      upvotes: json['upvotes'] as int,
      upvoted: json['upvoted'] as bool,
      ansCount: json['ansCount'] as int,
      shares: json['shares'] as int,
      acceptedAns: json['acceptedAns'] == null
          ? null
          : AnswerSubResponse.fromJson(
              json['acceptedAns'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestionSubResponseToJson(
        QuestionSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': _$TargetTypeEnumMap[instance.type],
      'userId': instance.userId,
      'userName': instance.userName,
      'photo': instance.photo,
      'createdAt': instance.createdAt.toIso8601String(),
      'targetName': instance.targetName,
      'targetId': instance.targetId,
      'content': instance.content,
      'upvotes': instance.upvotes,
      'upvoted': instance.upvoted,
      'ansCount': instance.ansCount,
      'shares': instance.shares,
      'acceptedAns': instance.acceptedAns,
    };

const _$TargetTypeEnumMap = {
  TargetType.phone: 'phone',
  TargetType.company: 'company',
};

AnswerSubResponse _$AnswerSubResponseFromJson(Map<String, dynamic> json) =>
    AnswerSubResponse(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      photo: json['photo'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      ownedAt: DateTime.parse(json['ownedAt'] as String),
      content: json['content'] as String,
      upvotes: json['upvotes'] as int,
      upvoted: json['upvoted'] as bool,
      repliesSubResponses: (json['replies'] as List<dynamic>)
          .map((e) => ReplySubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnswerSubResponseToJson(AnswerSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'photo': instance.photo,
      'createdAt': instance.createdAt.toIso8601String(),
      'ownedAt': instance.ownedAt.toIso8601String(),
      'content': instance.content,
      'upvotes': instance.upvotes,
      'upvoted': instance.upvoted,
      'replies': instance.repliesSubResponses,
    };
