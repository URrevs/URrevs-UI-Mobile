import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/base_response.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';

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
