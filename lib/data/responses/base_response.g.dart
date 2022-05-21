// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
    };

StatusResponse _$StatusResponseFromJson(Map<String, dynamic> json) =>
    StatusResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$StatusResponseToJson(StatusResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };
