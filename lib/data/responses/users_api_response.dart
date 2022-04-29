import 'package:json_annotation/json_annotation.dart';

part 'users_api_response.g.dart';

@JsonSerializable()
class AuthenticationResponse {
  bool success;
  String status;
  String token;
  AuthenticationResponse({
    required this.success,
    required this.status,
    required this.token,
  });

  factory AuthenticationResponse.fromJson(Map<String, Object?> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);

  @override
  String toString() =>
      'AuthenticationResponse(success: $success, status: $status, token: $token)';
}
