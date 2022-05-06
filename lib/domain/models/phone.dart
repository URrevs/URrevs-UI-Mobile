import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/models/search_result.dart';

class Phone extends Equatable {
  final String id;
  final String name;
  final String? companyLogo;
  const Phone({
    required this.id,
    required this.name,
    this.companyLogo,
  });

  @override
  List<Object?> get props => [id];

  SearchResult get toSearchResult => SearchResult(
        id: id,
        name: name,
        type: SearchType.phone,
      );
}
