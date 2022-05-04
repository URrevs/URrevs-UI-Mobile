import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_recent_searches.dart';

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
}
