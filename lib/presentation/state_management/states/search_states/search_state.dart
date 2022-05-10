import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class SearchState extends Equatable implements RequestState {}

class SearchInitialState extends SearchState implements InitialState {
  @override
  List<Object?> get props => [];
}

class SearchLoadingState extends SearchState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class SearchLoadedState extends SearchState implements LoadedState {
  final List<SearchResult> searchResults;

  SearchLoadedState({
    required this.searchResults,
  });
  @override
  List<Object?> get props => [];
}

class SearchErrorState extends SearchState implements ErrorState {
  @override
  final Failure failure;
  SearchErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
