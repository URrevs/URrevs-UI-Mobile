// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSubResponse _$UserSubResponseFromJson(Map<String, dynamic> json) =>
    UserSubResponse(
      id: json['_id'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String,
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
      picture: json['picture'] as String,
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
