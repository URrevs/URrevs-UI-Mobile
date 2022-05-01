// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'token': instance.token,
    };

GetMyProfileResponse _$GetMyProfileResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyProfileResponse(
      success: json['success'] as bool,
      userSubResponse:
          UserSubResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMyProfileResponseToJson(
        GetMyProfileResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'user': instance.userSubResponse,
    };

GetTheProfileOfAnotherUserResponse _$GetTheProfileOfAnotherUserResponseFromJson(
        Map<String, dynamic> json) =>
    GetTheProfileOfAnotherUserResponse(
      success: json['success'] as bool,
      anotherUserSubResponse:
          AnotherUserSubResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTheProfileOfAnotherUserResponseToJson(
        GetTheProfileOfAnotherUserResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'user': instance.anotherUserSubResponse,
    };
