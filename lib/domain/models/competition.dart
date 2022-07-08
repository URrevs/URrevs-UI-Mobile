import 'package:equatable/equatable.dart';

class Competition extends Equatable {
  final String id;
  final DateTime deadline;
  final int numWinners;
  final String prize;
  final String prizePic;
  final DateTime createdAt;
  const Competition({
    required this.id,
    required this.deadline,
    required this.numWinners,
    required this.prize,
    required this.prizePic,
    required this.createdAt,
  });

  bool get inProgress => deadline.isAfter(DateTime.now());

  @override
  List<Object?> get props => [id];
}
