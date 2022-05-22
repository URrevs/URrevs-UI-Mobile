// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_api_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCompetitionRequest _$AddCompetitionRequestFromJson(
        Map<String, dynamic> json) =>
    AddCompetitionRequest(
      deadline: DateTime.parse(json['deadline'] as String),
      numWinners: json['numWinners'] as int,
      prize: json['prize'] as String,
      prizePic: json['prizePic'] as String,
    );

Map<String, dynamic> _$AddCompetitionRequestToJson(
        AddCompetitionRequest instance) =>
    <String, dynamic>{
      'deadline': instance.deadline.toIso8601String(),
      'numWinners': instance.numWinners,
      'prize': instance.prize,
      'prizePic': instance.prizePic,
    };
