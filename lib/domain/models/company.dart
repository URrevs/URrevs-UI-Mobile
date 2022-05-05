import 'package:equatable/equatable.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';

class Company extends Equatable {
  final String id;
  final String name;

  /// Used in product profile screen
  final String? logo;
  const Company({
    required this.id,
    required this.name,
    this.logo,
  });

  @override
  List<Object?> get props => [id];

  SearchResult get toSearchResult => SearchResult(
        id: id,
        name: name,
        type: SearchType.company,
      );
}
