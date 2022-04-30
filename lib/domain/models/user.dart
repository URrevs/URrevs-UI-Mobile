import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String picture;
  final int points;
  const User({
    required this.id,
    required this.name,
    required this.picture,
    required this.points,
  });

  @override
  List<Object?> get props => [id];
}
