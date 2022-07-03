import 'package:dartz/dartz.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/search_state.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier({required this.searchMode}) : super(SearchInitialState());

  SearchMode searchMode;

  void search(String searchWord) async {
    state = SearchLoadingState();
    late Either<Failure, List<SearchResult>> response;
    switch (searchMode) {
      case SearchMode.productsAndCompanies:
        response =
            await GetIt.I<Repository>().searchProductsAndCompanies(searchWord);
        break;
      case SearchMode.products:
        response = await GetIt.I<Repository>().searchProducts(searchWord);
        break;
      case SearchMode.phones:
        response = await GetIt.I<Repository>().searchPhones(searchWord);
        break;
    }
    response.fold(
      (failure) => state = SearchErrorState(failure: failure),
      (searchResults) {
        state = SearchLoadedState(searchResults: searchResults);
        FirebaseAnalytics.instance.logSearch(searchTerm: searchWord);
      },
    );
  }

  void returnToInitialState() => state = SearchInitialState();
}
