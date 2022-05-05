import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class AddNewRecentSearchState extends Equatable
    implements RequestState {}

class AddNewRecentSearchInitialState extends AddNewRecentSearchState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class AddNewRecentSearchLoadingState extends AddNewRecentSearchState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class AddNewRecentSearchLoadedState extends AddNewRecentSearchState
    implements LoadedState {
  @override
  List<Object?> get props => [];
}

class AddNewRecentSearchErrorState extends AddNewRecentSearchState
    implements ErrorState {
  @override
  final Failure failure;
  AddNewRecentSearchErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
