import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/models/search_result.dart';

class Phone extends Equatable {
  final String id;
  final String name;

  /// Used in all products screen in showing companies logo beside each phone.
  final String? companyLogo;

  /// Used in phone profile screen in showing similar phones pictures.
  final String? picture;
  const Phone({
    required this.id,
    required this.name,
    this.companyLogo,
    this.picture,
  });

  @override
  List<Object?> get props => [id];

  SearchResult get toSearchResult => SearchResult(
        id: id,
        name: name,
        type: SearchType.phone,
      );
}
