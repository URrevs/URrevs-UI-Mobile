import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/get_my_recent_searches_state.dart';

class GetMyRecentSearchesNotifier
    extends StateNotifier<GetMyRecentSearchesState> {
  GetMyRecentSearchesNotifier() : super(GetMyRecentSearchesInitialState());

  void getMyRecentSearches() async {
    state = GetMyRecentSearchesLoadingState();
    final response = await GetIt.I<Repository>().getMyRecentSearches();
    response.fold(
      (failure) => state = GetMyRecentSearchesErrorState(failure: failure),
      (searchResults) {
        state = GetMyRecentSearchesLoadedState(searchResults: searchResults);
      },
    );
  }

  void removeRecentSearchFromState(String id) {
    final currentState = state;
    if (currentState is GetMyRecentSearchesLoadedState) {
      state = GetMyRecentSearchesLoadedState(
        searchResults: [
          for (var recentSearch in currentState.searchResults)
            if (recentSearch.id != id) recentSearch,
        ],
      );
    }
  }

  void addRecentSearchToState(SearchResult searchResult) {
    final currentState = state;
    if (currentState is GetMyRecentSearchesLoadedState) {
      List<SearchResult> newResults = [
        searchResult,
        ...currentState.searchResults,
      ];
      if (newResults.length > 5) newResults.length = 5;
      state = GetMyRecentSearchesLoadedState(searchResults: newResults);
    }
  }
}
