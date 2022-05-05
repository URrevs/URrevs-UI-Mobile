import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetAllCompaniesState extends Equatable implements RequestState {}

class GetAllCompaniesInitialState extends GetAllCompaniesState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetAllCompaniesLoadingState extends GetAllCompaniesState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetAllCompaniesLoadedState extends GetAllCompaniesState
    implements LoadedState, InfiniteScrollingState<Company> {
  @override
  final List<Company> infiniteScrollingItems;
  @override
  final bool roundsEnded;

  GetAllCompaniesLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return 'GetAllCompaniesLoadedState(infiniteScrollingItems: $infiniteScrollingItems, roundsEnded: $roundsEnded)';
  }
}

class GetAllCompaniesErrorState extends GetAllCompaniesState
    implements ErrorState {
  @override
  final Failure failure;
  GetAllCompaniesErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
