import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String? picture;
  final int points;

  /// Always null except in competitions screen.
  final int? rank;
  const User({
    required this.id,
    required this.name,
    required this.picture,
    required this.points,
    required this.rank,
  });

  @override
  List<Object?> get props => [id];
}
