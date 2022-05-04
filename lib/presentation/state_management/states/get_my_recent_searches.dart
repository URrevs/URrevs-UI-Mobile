import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetMyRecentSearchesState extends Equatable
    implements RequestState {}

class GetMyRecentSearchesInitialState extends GetMyRecentSearchesState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetMyRecentSearchesLoadingState extends GetMyRecentSearchesState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetMyRecentSearchesLoadedState extends GetMyRecentSearchesState
    implements LoadedState {
  final List<SearchResult> searchResults;

  GetMyRecentSearchesLoadedState({required this.searchResults});
  @override
  List<Object?> get props => [];
}

class GetMyRecentSearchesErrorState extends GetMyRecentSearchesState
    implements ErrorState {
  final Failure failure;
  GetMyRecentSearchesErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
