import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  bool success;
  BaseResponse({
    required this.success,
  });

  factory BaseResponse.fromJson(Map<String, Object?> json) =>
      _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable()
class StatusResponse extends BaseResponse {
  String status;
  StatusResponse({
    required bool success,
    required this.status,
  }) : super(success: success);

  factory StatusResponse.fromJson(Map<String, Object?> json) =>
      _$StatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StatusResponseToJson(this);
}
