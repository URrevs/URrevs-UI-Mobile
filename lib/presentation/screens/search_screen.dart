import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/data/requests/search_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/company_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/delete_recent_search_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/get_my_recent_searches_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/search_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_widgets/empty_list_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/fullscreen_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/search_text_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/recent_searches_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/suggested_searches_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

import '../resources/enums.dart';
import '../state_management/providers_parameters.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const String routeName = 'SearchScreen';

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  FocusNode focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final SearchProviderParams _searchProviderParams =
      SearchProviderParams(searchMode: SearchMode.productsAndCompanies);

  void _getMyRecentSearches() {
    ref.read(getMyRecentSearchesProvider.notifier).getMyRecentSearches();
  }

  void _search() {
    ref
        .read(searchProvider(_searchProviderParams).notifier)
        .search(_controller.text);
  }

  void _navigateToTargetProfile({
    required SearchResult searchResult,
    bool addNewRecentSearch = false,
  }) {
    if (addNewRecentSearch) {
      AddNewRecentSearchRequest request = AddNewRecentSearchRequest(
        id: searchResult.id,
        type: searchResult.type,
      );
      ref.read(addNewRecentSearchProvider.notifier).addNewRecentSearch(request);
      ref
          .read(getMyRecentSearchesProvider.notifier)
          .addRecentSearchToState(searchResult);
    }
    if (searchResult.type == SearchType.phone) {
      Navigator.of(context).pushNamed(
        ProductProfileScreen.routeName,
        arguments: ProductProfileScreenArgs(
          phoneId: searchResult.id,
          phoneName: searchResult.name,
        ),
      );
    } else {
      Navigator.of(context).pushNamed(
        CompanyProfileScreen.routeName,
        arguments: CompanyProfileScreenArgs(
          companyId: searchResult.id,
          companyName: searchResult.name,
        ),
      );
    }
  }

  void _deleteRecentSearch(SearchResult recentSearch) {
    DeleteRecentSearchRequest request =
        DeleteRecentSearchRequest(id: recentSearch.id);
    ref.read(deleteRecentSearchProvider.notifier).deleteRecentSearch(request);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _getMyRecentSearches);
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: deleteRecentSearchProvider,
      context: context,
    );
    return Scaffold(
      appBar: AppBars.appBarWithTitle(
        context: context,
        title: LocaleKeys.search.tr(),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          children: [
            SearchTextField(
              checkChosenSearchResult: false,
              key: ValueKey(0),
              fillColor: ColorManager.textFieldGrey,
              hintText: LocaleKeys.searchForAProductOrACompany.tr(),
              searchCtl: _controller,
              searchProviderParams: _searchProviderParams,
              hasErrorMsg: false,
            ),
            16.verticalSpace,
            _buildRecentSearches(),
            _buildSuggestedSearches(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches() {
    ref.listen<GetMyRecentSearchesState>(getMyRecentSearchesProvider,
        (previous, next) {
      showSnackBarWithoutActionAtError(state: next, context: context);
    });
    final suggestedSearchesState =
        ref.watch(searchProvider(_searchProviderParams));
    if (suggestedSearchesState is! SearchInitialState) {
      return SizedBox();
    }
    final recentSearchesState = ref.watch(getMyRecentSearchesProvider);
    if (recentSearchesState is GetMyRecentSearchesInitialState ||
        recentSearchesState is GetMyRecentSearchesLoadingState) {
      return RecentSearchesLoading();
    } else if (recentSearchesState is GetMyRecentSearchesErrorState) {
      return FullscreenErrorWidget(
        onRetry: _getMyRecentSearches,
        retryLastRequest: recentSearchesState.failure is RetryFailure,
      );
    }
    final loadedState = recentSearchesState as GetMyRecentSearchesLoadedState;
    if (loadedState.searchResults.isEmpty) {
      return EmptyListWidget();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.previousSearchResults.tr(),
          style: TextStyleManager.s16w500.copyWith(
            color: ColorManager.grey,
          ),
        ),
        23.verticalSpace,
        for (var recentSearch in loadedState.searchResults)
          ItemTile(
            title: recentSearch.name,
            subtitle: recentSearch.typeText,
            iconData: recentSearch.typeIconData,
            showDivider: true,
            onTap: () => _navigateToTargetProfile(searchResult: recentSearch),
            trailing: _buildDeleteRecentSearchButton(recentSearch),
          ),
      ],
    );
  }

  Widget _buildDeleteRecentSearchButton(SearchResult recentSearch) {
    final state = ref.watch(deleteRecentSearchProvider);
    if (state is DeleteRecentSearchLoadingState &&
        state.searchResultId == recentSearch.id) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: SizedBox(
          height: 18.h,
          width: 18.w,
          child: CircularProgressIndicator(
            color: ColorManager.black,
            strokeWidth: 3,
          ),
        ),
      );
    }
    return SizedBox(
      child: IconButton(
        onPressed: () => _deleteRecentSearch(recentSearch),
        icon: Icon(
          FontAwesomeIcons.xmark,
          size: 18.sp,
          color: ColorManager.black,
        ),
      ),
    );
  }

  Widget _buildSuggestedSearches() {
    ref.addErrorListener(
      provider: searchProvider(_searchProviderParams),
      context: context,
    );
    final state = ref.watch(searchProvider(_searchProviderParams));
    if (state is InitialState) {
      return SizedBox();
    } else if (state is LoadingState) {
      return SuggestedSearchesLoading();
    } else if (state is SearchErrorState) {
      return FullscreenErrorWidget(
        onRetry: _search,
        retryLastRequest: state.failure is RetryFailure,
      );
    }
    state as SearchLoadedState;
    if (state.searchResults.isEmpty) {
      return EmptyListWidget();
    }
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        for (var searchResult in state.searchResults)
          ItemTile(
            title: searchResult.name,
            subtitle: searchResult.typeText,
            showDivider: true,
            iconData: searchResult.typeIconData,
            onTap: () => _navigateToTargetProfile(
              searchResult: searchResult,
              addNewRecentSearch: true,
            ),
          ),
      ],
    );
  }
}
