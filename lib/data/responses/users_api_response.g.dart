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

GetMyOwnedPhonesResponse _$GetMyOwnedPhonesResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyOwnedPhonesResponse(
      success: json['success'] as bool,
      phonesSubResponses: (json['phones'] as List<dynamic>)
          .map((e) => PhoneSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyOwnedPhonesResponseToJson(
        GetMyOwnedPhonesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'phones': instance.phonesSubResponses,
    };

GetTheOwnedPhonesOfAnotherUserResponse
    _$GetTheOwnedPhonesOfAnotherUserResponseFromJson(
            Map<String, dynamic> json) =>
        GetTheOwnedPhonesOfAnotherUserResponse(
          success: json['success'] as bool,
          phonesSubResponses: (json['phones'] as List<dynamic>)
              .map((e) => PhoneSubResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetTheOwnedPhonesOfAnotherUserResponseToJson(
        GetTheOwnedPhonesOfAnotherUserResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'phones': instance.phonesSubResponses,
    };

GivePointsToUserResponse _$GivePointsToUserResponseFromJson(
        Map<String, dynamic> json) =>
    GivePointsToUserResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$GivePointsToUserResponseToJson(
        GivePointsToUserResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };
