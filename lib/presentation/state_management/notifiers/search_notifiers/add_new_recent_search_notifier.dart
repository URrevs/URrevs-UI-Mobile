import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/requests/search_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/add_new_recent_search_state.dart';

class AddNewRecentSearchNotifier
    extends StateNotifier<AddNewRecentSearchState> {
  AddNewRecentSearchNotifier() : super(AddNewRecentSearchInitialState());

  void addNewRecentSearch(AddNewRecentSearchRequest request) async {
    state = AddNewRecentSearchLoadingState();
    final response = await GetIt.I<Repository>().addNewRecentSearch(request);
    response.fold(
      (failure) => state = AddNewRecentSearchErrorState(failure: failure),
      (_) {
        state = AddNewRecentSearchLoadedState();
      },
    );
  }
}
