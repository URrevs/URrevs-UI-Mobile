import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class DeleteRecentSearchState extends Equatable
    implements RequestState {}

class DeleteRecentSearchInitialState extends DeleteRecentSearchState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class DeleteRecentSearchLoadingState extends DeleteRecentSearchState
    implements LoadingState {
  final String searchResultId;

  DeleteRecentSearchLoadingState({required this.searchResultId});
  @override
  List<Object?> get props => [];
}

class DeleteRecentSearchLoadedState extends DeleteRecentSearchState
    implements LoadedState {
  @override
  List<Object?> get props => [];
}

class DeleteRecentSearchErrorState extends DeleteRecentSearchState
    implements ErrorState {
  @override
  final Failure failure;
  DeleteRecentSearchErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
