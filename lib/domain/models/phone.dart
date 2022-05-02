import 'package:equatable/equatable.dart';

class Phone extends Equatable {
  final String id;
  final String name;
  final String? companyId;
  final String? companyName;
  const Phone({
    required this.id,
    required this.name,
    this.companyId,
    this.companyName,
  });

  @override
  List<Object?> get props => [id];
}
