import 'package:json_annotation/json_annotation.dart';

part 'base_requests.g.dart';

@JsonSerializable()
class AddInteractionRequest {
  String content;
  AddInteractionRequest({
    required this.content,
  });

  factory AddInteractionRequest.fromJson(Map<String, Object?> json) =>
      _$AddInteractionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddInteractionRequestToJson(this);
}
