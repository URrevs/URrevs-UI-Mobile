import 'package:json_annotation/json_annotation.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';

part 'sub_responses.g.dart';

@JsonSerializable()
class UserSubResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  String picture;
  int points;
  String refCode;

  UserSubResponse({
    required this.id,
    required this.name,
    required this.picture,
    required this.points,
    required this.refCode,
  });

  User get userModel =>
      User(id: id, name: name, picture: picture, points: points);

  factory UserSubResponse.fromJson(Map<String, Object?> json) =>
      _$UserSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserSubResponseToJson(this);
}
