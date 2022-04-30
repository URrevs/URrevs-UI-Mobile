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
