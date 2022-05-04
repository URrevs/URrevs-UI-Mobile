import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class SearchProductsAndCompaiesState extends Equatable
    implements RequestState {}

class SearchProductsAndCompaiesInitialState
    extends SearchProductsAndCompaiesState implements InitialState {
  @override
  List<Object?> get props => [];
}

class SearchProductsAndCompaiesLoadingState
    extends SearchProductsAndCompaiesState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class SearchProductsAndCompaiesLoadedState
    extends SearchProductsAndCompaiesState implements LoadedState {
  final List<Phone> phones;
  final List<Company> companies;

  SearchProductsAndCompaiesLoadedState({
    required this.phones,
    required this.companies,
  });
  @override
  List<Object?> get props => [];
}

class SearchProductsAndCompaiesErrorState extends SearchProductsAndCompaiesState
    implements ErrorState {
  @override
  final Failure failure;
  SearchProductsAndCompaiesErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
