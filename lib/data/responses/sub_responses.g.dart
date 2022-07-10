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
      requestedDelete: json['requestedDelete'] as bool,
    );

Map<String, dynamic> _$UserSubResponseToJson(UserSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('picture', instance.picture);
  val['points'] = instance.points;
  val['refCode'] = instance.refCode;
  val['requestedDelete'] = instance.requestedDelete;
  return val;
}

AnotherUserSubResponse _$AnotherUserSubResponseFromJson(
        Map<String, dynamic> json) =>
    AnotherUserSubResponse(
      id: json['_id'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String?,
      points: json['points'] as int,
    );

Map<String, dynamic> _$AnotherUserSubResponseToJson(
    AnotherUserSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('picture', instance.picture);
  val['points'] = instance.points;
  return val;
}

UserWithRankSubResponse _$UserWithRankSubResponseFromJson(
        Map<String, dynamic> json) =>
    UserWithRankSubResponse(
      id: json['_id'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String?,
      points: json['points'] as int,
      rank: json['rank'] as int,
    );

Map<String, dynamic> _$UserWithRankSubResponseToJson(
    UserWithRankSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('picture', instance.picture);
  val['points'] = instance.points;
  val['rank'] = instance.rank;
  return val;
}

PhoneSubResponse _$PhoneSubResponseFromJson(Map<String, dynamic> json) =>
    PhoneSubResponse(
      id: json['_id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      verificationRatio: (json['verificationRatio'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PhoneSubResponseToJson(PhoneSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'type': instance.type,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('verificationRatio', instance.verificationRatio);
  return val;
}

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
    CompanyWithLogoSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'type': instance.type,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('logo', instance.logo);
  return val;
}

PhoneWithCompanyLogogSubResponse _$PhoneWithCompanyLogogSubResponseFromJson(
        Map<String, dynamic> json) =>
    PhoneWithCompanyLogogSubResponse(
      id: json['_id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      companyLogo: json['companyLogo'] as String?,
    );

Map<String, dynamic> _$PhoneWithCompanyLogogSubResponseToJson(
    PhoneWithCompanyLogogSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'type': instance.type,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('companyLogo', instance.companyLogo);
  return val;
}

SpecsSubResponse _$SpecsSubResponseFromJson(Map<String, dynamic> json) =>
    SpecsSubResponse(
      id: json['_id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      picture: json['picture'] as String,
      companyId: json['companyId'] as String,
      companyName: json['companyName'] as String,
      priceEgp: (json['priceEgp'] as num?)?.toDouble(),
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
      weight: json['weight'] as String?,
      sim: json['sim'] as String?,
      screenType: json['screenType'] as String?,
      screenSize: json['screenSize'] as String?,
      screenResolution: json['screenResolution'] as String?,
    );

Map<String, dynamic> _$SpecsSubResponseToJson(SpecsSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'name': instance.name,
    'type': instance.type,
    'picture': instance.picture,
    'companyId': instance.companyId,
    'companyName': instance.companyName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('priceEgp', instance.priceEgp);
  writeNotNull('releaseDate', instance.releaseDate);
  writeNotNull('dimensions', instance.dimensions);
  writeNotNull('network', instance.network);
  writeNotNull('screenProtection', instance.screenProtection);
  writeNotNull('os', instance.os);
  writeNotNull('chipset', instance.chipset);
  writeNotNull('cpu', instance.cpu);
  writeNotNull('gpu', instance.gpu);
  writeNotNull('externalMem', instance.externalMem);
  writeNotNull('internalMem', instance.internalMem);
  writeNotNull('mainCam', instance.mainCam);
  writeNotNull('selfieCam', instance.selfieCam);
  writeNotNull('loudspeaker', instance.loudspeaker);
  writeNotNull('slot3.5mm', instance.slot3_5mm);
  writeNotNull('wlan', instance.wlan);
  writeNotNull('bluetooth', instance.bluetooth);
  writeNotNull('gps', instance.gps);
  writeNotNull('nfc', instance.nfc);
  writeNotNull('radio', instance.radio);
  writeNotNull('usb', instance.usb);
  writeNotNull('sensors', instance.sensors);
  writeNotNull('battery', instance.battery);
  writeNotNull('charging', instance.charging);
  writeNotNull('weight', instance.weight);
  writeNotNull('sim', instance.sim);
  writeNotNull('screenType', instance.screenType);
  writeNotNull('screenSize', instance.screenSize);
  writeNotNull('screenResolution', instance.screenResolution);
  return val;
}

PhoneStatsSubResponse _$PhoneStatsSubResponseFromJson(
        Map<String, dynamic> json) =>
    PhoneStatsSubResponse(
      views: json['views'] as int,
      generalRating: json['generalRating'] as num,
      companyRating: json['companyRating'] as num,
      uiRating: json['uiRating'] as num,
      manufacturingQuality: json['manufacturingQuality'] as num,
      valueForMoney: json['valueForMoney'] as num,
      camera: json['camera'] as num,
      callQuality: json['callQuality'] as num,
      battery: json['battery'] as num,
      owned: json['owned'] as bool,
      verificationRatio: (json['verificationRatio'] as num).toDouble(),
    );

Map<String, dynamic> _$PhoneStatsSubResponseToJson(
        PhoneStatsSubResponse instance) =>
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
      'owned': instance.owned,
      'verificationRatio': instance.verificationRatio,
    };

CompanyStatsSubResponse _$CompanyStatsSubResponseFromJson(
        Map<String, dynamic> json) =>
    CompanyStatsSubResponse(
      id: json['_id'] as String,
      name: json['name'] as String,
      views: json['views'] as int,
      rating: (json['rating'] as num).toDouble(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$CompanyStatsSubResponseToJson(
        CompanyStatsSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'views': instance.views,
      'rating': instance.rating,
      'type': instance.type,
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
      photo: json['picture'] as String?,
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
      verificationRatio: (json['verificationRatio'] as num).toDouble(),
    );

Map<String, dynamic> _$PhoneReviewSubResponseToJson(
    PhoneReviewSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'type': instance.type,
    'targetId': instance.targetId,
    'targetName': instance.targetName,
    'userId': instance.userId,
    'userName': instance.userName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('picture', instance.photo);
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['views'] = instance.views;
  val['likes'] = instance.likes;
  val['commentsCount'] = instance.commentsCount;
  val['shares'] = instance.shares;
  val['ownedAt'] = instance.ownedAt.toIso8601String();
  val['generalRating'] = instance.generalRating;
  val['uiRating'] = instance.uiRating;
  val['manufacturingQuality'] = instance.manufacturingQuality;
  val['valueForMoney'] = instance.valueForMoney;
  val['camera'] = instance.camera;
  val['callQuality'] = instance.callQuality;
  val['battery'] = instance.battery;
  val['pros'] = instance.pros;
  val['cons'] = instance.cons;
  val['liked'] = instance.liked;
  val['verificationRatio'] = instance.verificationRatio;
  return val;
}

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
          verificationRatio: (json['verificationRatio'] as num).toDouble(),
        );

Map<String, dynamic> _$PhoneReviewForAddPhoneReviewSubResponseToJson(
    PhoneReviewForAddPhoneReviewSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'type': instance.type,
    'phoneId': instance.phoneId,
    'phoneName': instance.phoneName,
    'userId': instance.userId,
    'userName': instance.userName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('picture', instance.photo);
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['ownedAt'] = instance.ownedAt.toIso8601String();
  val['views'] = instance.views;
  val['likes'] = instance.likes;
  val['commentsCount'] = instance.commentsCount;
  val['shares'] = instance.shares;
  val['generalRating'] = instance.generalRating;
  val['uiRating'] = instance.uiRating;
  val['manufacturingQuality'] = instance.manufacturingQuality;
  val['valueForMoney'] = instance.valueForMoney;
  val['camera'] = instance.camera;
  val['callQuality'] = instance.callQuality;
  val['battery'] = instance.battery;
  val['pros'] = instance.pros;
  val['cons'] = instance.cons;
  val['verificationRatio'] = instance.verificationRatio;
  return val;
}

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
      verificationRatio: (json['verificationRatio'] as num).toDouble(),
    );

Map<String, dynamic> _$CompanyReviewSubResponseToJson(
    CompanyReviewSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'type': instance.type,
    'targetId': instance.targetId,
    'targetName': instance.targetName,
    'userId': instance.userId,
    'userName': instance.userName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('picture', instance.photo);
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['corresPhoneRev'] = instance.corresPhoneRev;
  val['views'] = instance.views;
  val['likes'] = instance.likes;
  val['commentsCount'] = instance.commentsCount;
  val['shares'] = instance.shares;
  val['generalRating'] = instance.generalRating;
  val['pros'] = instance.pros;
  val['cons'] = instance.cons;
  val['liked'] = instance.liked;
  val['verificationRatio'] = instance.verificationRatio;
  return val;
}

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

Map<String, dynamic> _$ReplySubResponseToJson(ReplySubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'userId': instance.userId,
    'userName': instance.userName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userPicture', instance.photo);
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['content'] = instance.content;
  val['likes'] = instance.likes;
  val['liked'] = instance.liked;
  return val;
}

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
      repliesSubResponses: (json['replies'] as List<dynamic>?)
          ?.map((e) => ReplySubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentSubResponseToJson(CommentSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'userId': instance.userId,
    'userName': instance.userName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userPicture', instance.photo);
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['content'] = instance.content;
  val['likes'] = instance.likes;
  val['liked'] = instance.liked;
  writeNotNull('replies', instance.repliesSubResponses);
  return val;
}

QuestionSubResponse _$QuestionSubResponseFromJson(Map<String, dynamic> json) =>
    QuestionSubResponse(
      id: json['_id'] as String,
      type: $enumDecode(_$TargetTypeEnumMap, json['type']),
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      photo: json['picture'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      targetName: json['targetName'] as String,
      targetId: json['targetId'] as String,
      content: json['content'] as String,
      upvotes: json['upvotes'] as int,
      upvoted: json['upvoted'] as bool?,
      ansCount: json['ansCount'] as int,
      shares: json['shares'] as int,
      acceptedAns: json['acceptedAns'] == null
          ? null
          : AnswerSubResponse.fromJson(
              json['acceptedAns'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestionSubResponseToJson(QuestionSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'type': _$TargetTypeEnumMap[instance.type],
    'userId': instance.userId,
    'userName': instance.userName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('picture', instance.photo);
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['targetName'] = instance.targetName;
  val['targetId'] = instance.targetId;
  val['content'] = instance.content;
  val['upvotes'] = instance.upvotes;
  writeNotNull('upvoted', instance.upvoted);
  val['ansCount'] = instance.ansCount;
  val['shares'] = instance.shares;
  writeNotNull('acceptedAns', instance.acceptedAns);
  return val;
}

const _$TargetTypeEnumMap = {
  TargetType.phone: 'phone',
  TargetType.company: 'company',
};

PhoneQuestionSubResponse _$PhoneQuestionSubResponseFromJson(
        Map<String, dynamic> json) =>
    PhoneQuestionSubResponse(
      id: json['_id'] as String,
      type: $enumDecode(_$TargetTypeEnumMap, json['type']),
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      photo: json['picture'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      phoneName: json['phoneName'] as String,
      phoneId: json['phoneId'] as String,
      content: json['content'] as String,
      upvotes: json['upvotes'] as int,
      upvoted: json['upvoted'] as bool?,
      ansCount: json['ansCount'] as int,
      shares: json['shares'] as int,
      acceptedAns: json['acceptedAns'] == null
          ? null
          : AnswerSubResponse.fromJson(
              json['acceptedAns'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PhoneQuestionSubResponseToJson(
    PhoneQuestionSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'type': _$TargetTypeEnumMap[instance.type],
    'userId': instance.userId,
    'userName': instance.userName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('picture', instance.photo);
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['phoneName'] = instance.phoneName;
  val['phoneId'] = instance.phoneId;
  val['content'] = instance.content;
  val['upvotes'] = instance.upvotes;
  writeNotNull('upvoted', instance.upvoted);
  val['ansCount'] = instance.ansCount;
  val['shares'] = instance.shares;
  writeNotNull('acceptedAns', instance.acceptedAns);
  return val;
}

CompanyQuestionSubResponse _$CompanyQuestionSubResponseFromJson(
        Map<String, dynamic> json) =>
    CompanyQuestionSubResponse(
      id: json['_id'] as String,
      type: $enumDecode(_$TargetTypeEnumMap, json['type']),
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      photo: json['picture'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      companyName: json['companyName'] as String,
      companyId: json['companyId'] as String,
      content: json['content'] as String,
      upvotes: json['upvotes'] as int,
      upvoted: json['upvoted'] as bool?,
      ansCount: json['ansCount'] as int,
      shares: json['shares'] as int,
      acceptedAns: json['acceptedAns'] == null
          ? null
          : AnswerSubResponse.fromJson(
              json['acceptedAns'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompanyQuestionSubResponseToJson(
    CompanyQuestionSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'type': _$TargetTypeEnumMap[instance.type],
    'userId': instance.userId,
    'userName': instance.userName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('picture', instance.photo);
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['companyName'] = instance.companyName;
  val['companyId'] = instance.companyId;
  val['content'] = instance.content;
  val['upvotes'] = instance.upvotes;
  writeNotNull('upvoted', instance.upvoted);
  val['ansCount'] = instance.ansCount;
  val['shares'] = instance.shares;
  writeNotNull('acceptedAns', instance.acceptedAns);
  return val;
}

AnswerSubResponse _$AnswerSubResponseFromJson(Map<String, dynamic> json) =>
    AnswerSubResponse(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      photo: json['picture'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      ownedAt: json['ownedAt'] == null
          ? null
          : DateTime.parse(json['ownedAt'] as String),
      content: json['content'] as String,
      upvotes: json['upvotes'] as int,
      upvoted: json['upvoted'] as bool,
      repliesSubResponses: (json['replies'] as List<dynamic>?)
          ?.map((e) => ReplySubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnswerSubResponseToJson(AnswerSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'userId': instance.userId,
    'userName': instance.userName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('picture', instance.photo);
  val['createdAt'] = instance.createdAt.toIso8601String();
  writeNotNull('ownedAt', instance.ownedAt?.toIso8601String());
  val['content'] = instance.content;
  val['upvotes'] = instance.upvotes;
  val['upvoted'] = instance.upvoted;
  writeNotNull('replies', instance.repliesSubResponses);
  return val;
}

CompetitionSubResponse _$CompetitionSubResponseFromJson(
        Map<String, dynamic> json) =>
    CompetitionSubResponse(
      id: json['_id'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      numWinners: json['numWinners'] as int,
      prize: json['prize'] as String,
      prizePic: json['prizePic'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CompetitionSubResponseToJson(
        CompetitionSubResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'deadline': instance.deadline.toIso8601String(),
      'numWinners': instance.numWinners,
      'prize': instance.prize,
      'prizePic': instance.prizePic,
      'createdAt': instance.createdAt.toIso8601String(),
    };

ReportSubResponse _$ReportSubResponseFromJson(Map<String, dynamic> json) =>
    ReportSubResponse(
      id: json['_id'] as String,
      type: $enumDecode(_$ReportTypeEnumMap, json['type']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      reason: ReportSubResponse._intToComplaintReason(json['reason'] as int),
      info: json['info'] as String?,
      reporterId: json['reporterId'] as String,
      reporterName: json['reporterName'] as String,
      reporterPicture: json['reporterPicture'] as String?,
      reporteeId: json['reporteeId'] as String,
      reporteeName: json['reporteeName'] as String,
      phoneReviewSubResponse: json['phoneRev'] as String?,
      companyReviewSubResponse: json['companyRev'] as String?,
      phoneQuestionSubResponse: json['phoneQues'] as String?,
      companyQuestionSubResponse: json['companyQues'] as String?,
      phoneCommentSubResponse: json['phoneComment'] as String?,
      companyCommentSubResponse: json['companyComment'] as String?,
      phoneAnswerSubResponse: json['phoneAnswer'] as String?,
      companyAnswerSubResponse: json['companyAnswer'] as String?,
      phoneCommentReplySubResponse: json['phoneCommentReply'] as String?,
      companyCommentReplySubResponse: json['companyCommentReply'] as String?,
      phoneAnswerReplySubResponse: json['phoneAnswerReply'] as String?,
      companyAnswerReplySubResponse: json['companyAnswerReply'] as String?,
      reporteeBlocked: json['reporteeBlocked'] as bool,
      contentHidden: json['contentHidden'] as bool,
    );

Map<String, dynamic> _$ReportSubResponseToJson(ReportSubResponse instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'type': _$ReportTypeEnumMap[instance.type],
    'createdAt': instance.createdAt.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'reason', ReportSubResponse._complaintReasonToInt(instance.reason));
  writeNotNull('info', instance.info);
  val['reporterId'] = instance.reporterId;
  val['reporterName'] = instance.reporterName;
  writeNotNull('reporterPicture', instance.reporterPicture);
  val['reporteeId'] = instance.reporteeId;
  val['reporteeName'] = instance.reporteeName;
  writeNotNull('phoneRev', instance.phoneReviewSubResponse);
  writeNotNull('companyRev', instance.companyReviewSubResponse);
  writeNotNull('phoneQues', instance.phoneQuestionSubResponse);
  writeNotNull('companyQues', instance.companyQuestionSubResponse);
  writeNotNull('phoneComment', instance.phoneCommentSubResponse);
  writeNotNull('companyComment', instance.companyCommentSubResponse);
  writeNotNull('phoneAnswer', instance.phoneAnswerSubResponse);
  writeNotNull('companyAnswer', instance.companyAnswerSubResponse);
  writeNotNull('phoneCommentReply', instance.phoneCommentReplySubResponse);
  writeNotNull('companyCommentReply', instance.companyCommentReplySubResponse);
  writeNotNull('phoneAnswerReply', instance.phoneAnswerReplySubResponse);
  writeNotNull('companyAnswerReply', instance.companyAnswerReplySubResponse);
  val['reporteeBlocked'] = instance.reporteeBlocked;
  val['contentHidden'] = instance.contentHidden;
  return val;
}

const _$ReportTypeEnumMap = {
  ReportType.phoneReview: 'phoneReview',
  ReportType.companyReview: 'companyReview',
  ReportType.phoneQuestion: 'phoneQuestion',
  ReportType.companyQuestion: 'companyQuestion',
  ReportType.phoneComment: 'phoneComment',
  ReportType.companyComment: 'companyComment',
  ReportType.phoneAnswer: 'phoneAnswer',
  ReportType.companyAnswer: 'companyAnswer',
  ReportType.phoneCommentReply: 'phoneCommentReply',
  ReportType.companyCommentReply: 'companyCommentReply',
  ReportType.phoneAnswerReply: 'phoneAnswerReply',
  ReportType.companyAnswerReply: 'companyAnswerReply',
};
