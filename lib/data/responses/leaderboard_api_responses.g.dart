// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCompetitionResponse _$AddCompetitionResponseFromJson(
        Map<String, dynamic> json) =>
    AddCompetitionResponse(
      success: json['success'] as bool,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$AddCompetitionResponseToJson(
        AddCompetitionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      '_id': instance.id,
    };

GetLatestCompetitionResponse _$GetLatestCompetitionResponseFromJson(
        Map<String, dynamic> json) =>
    GetLatestCompetitionResponse(
      success: json['success'] as bool,
      competitionSubResponse: CompetitionSubResponse.fromJson(
          json['competition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetLatestCompetitionResponseToJson(
        GetLatestCompetitionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'competition': instance.competitionSubResponse,
    };

GetTopUsersInCompetitionResponse _$GetTopUsersInCompetitionResponseFromJson(
        Map<String, dynamic> json) =>
    GetTopUsersInCompetitionResponse(
      success: json['success'] as bool,
      usersSubResponses: (json['users'] as List<dynamic>)
          .map(
              (e) => AnotherUserSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetTopUsersInCompetitionResponseToJson(
        GetTopUsersInCompetitionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'users': instance.usersSubResponses,
    };

GetMyRankInCompetitionResponse _$GetMyRankInCompetitionResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyRankInCompetitionResponse(
      success: json['success'] as bool,
      userSubResponse: UserWithRankSubResponse.fromJson(
          json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetMyRankInCompetitionResponseToJson(
        GetMyRankInCompetitionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'user': instance.userSubResponse,
    };
