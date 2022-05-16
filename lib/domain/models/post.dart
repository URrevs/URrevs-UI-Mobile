import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String id;
  const Post({
    required this.id,
  });

  @override
  List<Object?> get props => [id];

}
