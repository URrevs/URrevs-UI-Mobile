import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

enum SearchType { phone, company }

class SearchResult extends Equatable {
  final String id;
  final String name;
  final SearchType type;
  const SearchResult({
    required this.id,
    required this.name,
    required this.type,
  });

  String get typeText {
    switch (type) {
      case SearchType.phone:
        return LocaleKeys.smartphone.tr();
      case SearchType.company:
        return LocaleKeys.company.tr();
    }
  }

  IconData get typeIconData {
    switch (type) {
      case SearchType.phone:
        return Icons.smartphone;
      case SearchType.company:
        return Icons.business;
    }
  }

  TargetType get targetType {
    switch (type) {
      case SearchType.phone:
        return TargetType.phone;
      case SearchType.company:
        return TargetType.company;
    }
  }

  @override
  List<Object?> get props => [id, type];
}
