import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/requests/search_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/delete_recent_search_state.dart';

class DeleteRecentSearchNotifier
    extends StateNotifier<DeleteRecentSearchState> {
  DeleteRecentSearchNotifier(this.ref)
      : super(DeleteRecentSearchInitialState());

  AutoDisposeStateNotifierProviderRef ref;

  void deleteRecentSearch(DeleteRecentSearchRequest request) async {
    state = DeleteRecentSearchLoadingState(searchResultId: request.id);
    final response = await GetIt.I<Repository>().deleteRecentSearch(request);
    response.fold(
      (failure) => state = DeleteRecentSearchErrorState(failure: failure),
      (_) {
        state = DeleteRecentSearchLoadedState();
        ref
            .read(getMyRecentSearchesProvider.notifier)
            .removeRecentSearchFromState(request.id);
      },
    );
  }
}
