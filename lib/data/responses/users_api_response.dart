import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/base_response.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';

part 'users_api_response.g.dart';

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  String status;
  String token;
  AuthenticationResponse({
    required bool success,
    required this.status,
    required this.token,
  }) : super(success: success);

  factory AuthenticationResponse.fromJson(Map<String, Object?> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);

  @override
  String toString() =>
      'AuthenticationResponse(success: $success, status: $status, token: $token)';
}

@JsonSerializable()
class GetMyProfileResponse extends BaseResponse {
  @JsonKey(name: 'user')
  UserSubResponse userSubResponse;
  GetMyProfileResponse({
    required bool success,
    required this.userSubResponse,
  }) : super(success: success);

  factory GetMyProfileResponse.fromJson(Map<String, Object?> json) =>
      _$GetMyProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetMyProfileResponseToJson(this);
}

@JsonSerializable()
class GetTheProfileOfAnotherUserResponse extends BaseResponse {
  @JsonKey(name: 'user')
  AnotherUserSubResponse anotherUserSubResponse;
  GetTheProfileOfAnotherUserResponse({
    required bool success,
    required this.anotherUserSubResponse,
  }) : super(success: success);

  factory GetTheProfileOfAnotherUserResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetTheProfileOfAnotherUserResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetTheProfileOfAnotherUserResponseToJson(this);
}

@JsonSerializable()
class GetMyOwnedPhonesResponse extends BaseResponse {
  @JsonKey(name: 'phones')
  List<PhoneSubResponse> phonesSubResponses;
  GetMyOwnedPhonesResponse({
    required bool success,
    required this.phonesSubResponses,
  }) : super(success: success);

  List<Phone> get phonesModels =>
      phonesSubResponses.map((p) => p.phoneModel).toList();

  factory GetMyOwnedPhonesResponse.fromJson(Map<String, Object?> json) =>
      _$GetMyOwnedPhonesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetMyOwnedPhonesResponseToJson(this);
}

@JsonSerializable()
class GetTheOwnedPhonesOfAnotherUserResponse extends BaseResponse {
  @JsonKey(name: 'phones')
  List<PhoneSubResponse> phonesSubResponses;
  GetTheOwnedPhonesOfAnotherUserResponse({
    required bool success,
    required this.phonesSubResponses,
  }) : super(success: success);

  List<Phone> get phonesModels =>
      phonesSubResponses.map((p) => p.phoneModel).toList();

  factory GetTheOwnedPhonesOfAnotherUserResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetTheOwnedPhonesOfAnotherUserResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetTheOwnedPhonesOfAnotherUserResponseToJson(this);
}
