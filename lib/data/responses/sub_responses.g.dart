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
