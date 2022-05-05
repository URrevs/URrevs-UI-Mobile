import 'package:equatable/equatable.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';

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

  SearchResult get toSearchResult => SearchResult(
        id: id,
        name: name,
        type: SearchType.phone,
      );
}
