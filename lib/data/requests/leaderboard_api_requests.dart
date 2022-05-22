import 'package:json_annotation/json_annotation.dart';

part 'leaderboard_api_requests.g.dart';

@JsonSerializable()
class AddCompetitionRequest {
  DateTime deadline;
  int numWinners;
  String prize;
  String prizePic;
  AddCompetitionRequest({
    required this.deadline,
    required this.numWinners,
    required this.prize,
    required this.prizePic,
  });

  factory AddCompetitionRequest.fromJson(Map<String, Object?> json) =>
      _$AddCompetitionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddCompetitionRequestToJson(this);
}
