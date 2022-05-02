import 'package:json_annotation/json_annotation.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';

import 'package:urrevs_ui_mobile/domain/models/user.dart';

part 'sub_responses.g.dart';

@JsonSerializable()
class UserSubResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  String? picture;
  int points;
  String refCode;

  UserSubResponse({
    required this.id,
    required this.name,
    this.picture,
    required this.points,
    required this.refCode,
  });

  User get userModel =>
      User(id: id, name: name, picture: picture, points: points);

  factory UserSubResponse.fromJson(Map<String, Object?> json) =>
      _$UserSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserSubResponseToJson(this);
}

@JsonSerializable()
class AnotherUserSubResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  String? picture;
  int points;

  AnotherUserSubResponse({
    required this.id,
    required this.name,
    required this.picture,
    required this.points,
  });

  User get userModel =>
      User(id: id, name: name, picture: picture, points: points);

  factory AnotherUserSubResponse.fromJson(Map<String, Object?> json) =>
      _$AnotherUserSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AnotherUserSubResponseToJson(this);
}

@JsonSerializable()
class PhoneSubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String name;

  PhoneSubResponse({
    required this.id,
    required this.type,
    required this.name,
  });

  Phone get phoneModel => Phone(id: id, name: name);

  factory PhoneSubResponse.fromJson(Map<String, Object?> json) =>
      _$PhoneSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneSubResponseToJson(this);
}
