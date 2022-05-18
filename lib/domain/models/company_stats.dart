import 'package:equatable/equatable.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';

class CompanyStats extends Equatable {
  final String id;
  final String name;
  final int views;
  final double rating;
  final String type;
  const CompanyStats({
    required this.id,
    required this.name,
    required this.views,
    required this.rating,
    required this.type,
  });

  Company get company => Company(id: id, name: name);

  @override
  List<Object?> get props => [];
}
