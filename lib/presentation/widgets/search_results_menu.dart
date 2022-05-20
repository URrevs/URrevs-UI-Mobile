import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/search_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/no_glowing_scroll_behavior.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_widgets/empty_list_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/partial_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/small_search_list_loading.dart';

class SearchResultsMenu extends ConsumerWidget {
  const SearchResultsMenu({
    Key? key,
    required this.searchProviderParams,
    required this.hideResults,
    required this.onRetrySearch,
    required this.chooseSearchResult,
  }) : super(key: key);

  final SearchProviderParams searchProviderParams;
  final bool hideResults;
  final VoidCallback onRetrySearch;
  final ValueChanged<SearchResult> chooseSearchResult;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(searchProvider(searchProviderParams));
    ref.addErrorListener(
      provider: searchProvider(searchProviderParams),
      context: context,
    );
    if (hideResults) {
      return SizedBox();
    }
    if (state is InitialState) {
      return SizedBox();
    } else if (state is LoadingState) {
      return SmallSearchingListLoading();
    } else if (state is SearchErrorState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          PartialErrorWidget(
            onRetry: onRetrySearch,
            retryLastRequest: state.failure is RetryFailure,
          ),
        ],
      );
    }
    state as SearchLoadedState;
    if (state.searchResults.isEmpty) {
      return EmptyListWidget();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        ScrollConfiguration(
          behavior: NoGlowingScrollBehaviour(),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              for (var searchResult in state.searchResults)
                ListTile(
                  title: Text(
                    searchResult.name,
                    style: TextStyleManager.s16w400.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                  onTap: () => chooseSearchResult(searchResult),
                )
            ],
          ),
        ),
      ],
    );
  }
}
