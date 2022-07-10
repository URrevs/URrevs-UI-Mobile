import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

class Phone extends Equatable {
  final String id;
  final String name;
  final double? verificationRatio;

  /// Used in all products screen in showing companies logo beside each phone.
  final String? companyLogo;

  /// Used in phone profile screen in showing similar phones pictures.
  final String? picture;
  const Phone({
    required this.id,
    required this.name,
    this.companyLogo,
    this.picture,
    this.verificationRatio,
  });

  VerificationStatus get verificationStatus {
    if (verificationRatio == 0) {
      return VerificationStatus.unverified;
    } else if (verificationRatio == -1) {
      return VerificationStatus.iphone;
    } else {
      return VerificationStatus.verified;
    }
  }

  @override
  List<Object?> get props => [id];

  SearchResult get toSearchResult => SearchResult(
        id: id,
        name: name,
        type: SearchType.phone,
      );

  Phone copyWith({
    String? id,
    String? name,
    double? verificationRatio,
    String? companyLogo,
    String? picture,
  }) {
    return Phone(
      id: id ?? this.id,
      name: name ?? this.name,
      verificationRatio: verificationRatio ?? this.verificationRatio,
      companyLogo: companyLogo ?? this.companyLogo,
      picture: picture ?? this.picture,
    );
  }

  @override
  String toString() {
    return 'Phone(id: $id, name: $name, verificationRatio: $verificationRatio, companyLogo: $companyLogo, picture: $picture)';
  }
}
