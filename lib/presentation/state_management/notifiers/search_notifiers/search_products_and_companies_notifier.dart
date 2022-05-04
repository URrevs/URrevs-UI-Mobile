import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/search_products_and_companies_state.dart';

class SearchProductsAndCompaiesNotifier
    extends StateNotifier<SearchProductsAndCompaiesState> {
  SearchProductsAndCompaiesNotifier()
      : super(SearchProductsAndCompaiesInitialState());

  void searchProductsAndCompanies(String searchWord) async {
    state = SearchProductsAndCompaiesLoadingState();
    final response =
        await GetIt.I<Repository>().searchProductsAndCompanies(searchWord);
    response.fold(
      (failure) =>
          state = SearchProductsAndCompaiesErrorState(failure: failure),
      (response) {
        state = SearchProductsAndCompaiesLoadedState(
          phones: response.phonesModels,
          companies: response.companiesModels,
        );
      },
    );
  }
}
