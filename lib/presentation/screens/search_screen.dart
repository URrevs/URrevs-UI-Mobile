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
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/company_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/delete_recent_search_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/get_my_recent_searches.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_list_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/fullscreen_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/recent_searches_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const String routeName = 'SearchScreen';

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  FocusNode focusNode = FocusNode();

  void _getMyRecentSearches() {
    ref.read(getMyRecentSearchesProvider.notifier).getMyRecentSearches();
  }

  void _navigateToTargetProfile({
    required SearchResult searchResult,
    bool addNewRecentSearch = false,
  }) {
    if (addNewRecentSearch) {
      AddNewRecentSearchRequest request = AddNewRecentSearchRequest(
        productId: searchResult.id,
        type: searchResult.type,
      );
      ref.read(addNewRecentSearchProvider.notifier).addNewRecentSearch(request);
    }
    if (searchResult.type == SearchType.phone) {
      Navigator.of(context).pushNamed(ProductProfileScreen.routeName);
    } else {
      Navigator.of(context).pushNamed(CompanyProfileScreen.routeName);
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
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildTextField(),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 21.sp,
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
            16.verticalSpace,
            Text(
              LocaleKeys.previousSearchResults.tr(),
              style: TextStyleManager.s16w500.copyWith(
                color: ColorManager.grey,
              ),
            ),
            23.verticalSpace,
            _buildRecentSearches()
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    final InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40.r),
      borderSide: BorderSide(width: 0.5, color: ColorManager.strokeGrey),
    );
    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: TextField(
        focusNode: focusNode,
        style: TextStyleManager.s16w300,
        decoration: InputDecoration(
          hintText: LocaleKeys.searchForAProductOrACompany.tr(),
          filled: true,
          fillColor: ColorManager.textFieldGrey,
          focusColor: Colors.red,
          errorBorder: inputBorder,
          disabledBorder: inputBorder,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
        ),
      ),
    );
  }

  Widget _buildRecentSearches() {
    ref.listen<GetMyRecentSearchesState>(getMyRecentSearchesProvider,
        (previous, next) {
      showSnackBarWithoutActionAtError(state: next, context: context);
    });
    final state = ref.watch(getMyRecentSearchesProvider);
    if (state is GetMyRecentSearchesInitialState ||
        state is GetMyRecentSearchesLoadingState) {
      return RecentSearchesLoading();
    } else if (state is GetMyRecentSearchesErrorState) {
      return FullscreenErrorWidget(
        onRetry: _getMyRecentSearches,
        retryLastRequest: state.failure is RetryFailure,
      );
    }
    final loadedState = state as GetMyRecentSearchesLoadedState;
    if (loadedState.searchResults.isEmpty) {
      return EmptyListWidget();
    }
    return Column(
      children: [
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
}
