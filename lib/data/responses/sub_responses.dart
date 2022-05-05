import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
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

@JsonSerializable()
class CompanySubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String name;

  CompanySubResponse({
    required this.id,
    required this.type,
    required this.name,
  });

  Company get companyModel => Company(id: id, name: name);

  factory CompanySubResponse.fromJson(Map<String, Object?> json) =>
      _$CompanySubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanySubResponseToJson(this);
}

@JsonSerializable()
class RecentSearchSubResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  SearchType type;

  RecentSearchSubResponse({
    required this.id,
    required this.type,
    required this.name,
  });

  SearchResult get searchResult => SearchResult(id: id, name: name, type: type);

  factory RecentSearchSubResponse.fromJson(Map<String, Object?> json) =>
      _$RecentSearchSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RecentSearchSubResponseToJson(this);
}

@JsonSerializable()
class CompanyWithLogoSubResponse {
  @JsonKey(name: '_id')
  String id;
  String type;
  String name;
  String? logo;

  CompanyWithLogoSubResponse({
    required this.id,
    required this.type,
    required this.name,
    this.logo,
  });

  Company get companyModel => Company(id: id, name: name, logo: logo);

  factory CompanyWithLogoSubResponse.fromJson(Map<String, Object?> json) =>
      _$CompanyWithLogoSubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyWithLogoSubResponseToJson(this);
}

@JsonSerializable()
class PhoneWithCompanyIdAndNameSubResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  String companyId;
  String companyName;

  PhoneWithCompanyIdAndNameSubResponse({
    required this.id,
    required this.name,
    required this.companyId,
    required this.companyName,
  });

  Phone get phoneModel => Phone(
        id: id,
        name: name,
        companyId: companyId,
        companyName: companyName,
      );

  factory PhoneWithCompanyIdAndNameSubResponse.fromJson(
          Map<String, Object?> json) =>
      _$PhoneWithCompanyIdAndNameSubResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$PhoneWithCompanyIdAndNameSubResponseToJson(this);
}
