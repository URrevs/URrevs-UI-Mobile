import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/base_response.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/competition.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';

part 'leaderboard_api_responses.g.dart';

@JsonSerializable()
class AddCompetitionResponse extends BaseResponse {
  @JsonKey(name: '_id')
  String id;
  AddCompetitionResponse({
    required bool success,
    required this.id,
  }) : super(success: success);

  factory AddCompetitionResponse.fromJson(Map<String, Object?> json) =>
      _$AddCompetitionResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AddCompetitionResponseToJson(this);
}

@JsonSerializable()
class GetLatestCompetitionResponse extends BaseResponse {
  @JsonKey(name: 'competition')
  CompetitionSubResponse competitionSubResponse;
  GetLatestCompetitionResponse({
    required bool success,
    required this.competitionSubResponse,
  }) : super(success: success);

  factory GetLatestCompetitionResponse.fromJson(Map<String, Object?> json) =>
      _$GetLatestCompetitionResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetLatestCompetitionResponseToJson(this);
}

@JsonSerializable()
class GetTopUsersInCompetitionResponse extends BaseResponse {
  @JsonKey(name: 'users')
  List<AnotherUserSubResponse> usersSubResponses;
  GetTopUsersInCompetitionResponse({
    required bool success,
    required this.usersSubResponses,
  }) : super(success: success);

  List<User> get usersModels {
    return usersSubResponses.map((u) => u.userModel).toList();
  }

  factory GetTopUsersInCompetitionResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetTopUsersInCompetitionResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetTopUsersInCompetitionResponseToJson(this);
}

@JsonSerializable()
class GetMyRankInCompetitionResponse extends BaseResponse {
  @JsonKey(name: 'user')
  UserWithRankSubResponse userSubResponse;
  GetMyRankInCompetitionResponse({
    required bool success,
    required this.userSubResponse,
  }) : super(success: success);

  factory GetMyRankInCompetitionResponse.fromJson(Map<String, Object?> json) =>
      _$GetMyRankInCompetitionResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetMyRankInCompetitionResponseToJson(this);
}
