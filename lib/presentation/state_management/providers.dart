import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/authentication_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/companies_notifiers/get_all_companies_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/get_current_user_image_url_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/get_info_about_latest_update.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/get_my_owned_phones_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/get_my_profile_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/phones_notifier/get_all_phones_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/phones_notifier/get_two_phones_specs_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/search_notifiers/add_new_recent_search_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/search_notifiers/delete_recent_search_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/search_notifiers/get_my_recent_searches_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/get_the_profile_of_another_user.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/give_points_to_user_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/search_notifiers/search_products_and_companies_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/theme_mode_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/update_targets_from_source_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/companies_states/get_all_companies_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_current_user_image_url_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_info_about_latest_update_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_owned_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_all_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_phone_specs_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_phone_statistical_info_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_phones_from_certain_company_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_similar_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_two_phones_specs_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/indicate_user_compared_between_two_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_company_review_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_phone_review_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/add_new_recent_search_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/delete_recent_search_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/get_my_recent_searches_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_user_profile_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_the_profile_of_another_user_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/give_points_to_user_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/search_products_and_companies_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/update_targets_from_source_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/fullscreen_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/partial_error_widget.dart';

import 'notifiers/phones_notifier/get_phone_specs_notifier.dart';
import 'notifiers/phones_notifier/get_phones_from_certain_company_notifier.dart';
import 'notifiers/phones_notifier/get_similar_phones_notifier.dart';
import 'notifiers/phones_notifier/indicate_user_compared_between_two_phones_notifier.dart';
import 'notifiers/reviews_notifiers/get_company_review_notifier.dart';
import 'notifiers/reviews_notifiers/get_phone_review_notifier.dart';
import 'notifiers/search_notifiers/get_phone_statistical_info_notifier.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
    (ref) => ThemeModeNotifier());

final authenticationProvider =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>(
        (ref) => AuthenticationNotifier());

final givePointsToUserProvider =
    StateNotifierProvider<GivePointsToUserNotifier, GivePointsToUserState>(
        (ref) => GivePointsToUserNotifier());

final getMyProfileProvider =
    StateNotifierProvider<GetMyProfileNotifier, GetMyProfileState>(
        (ref) => GetMyProfileNotifier());

final getCurrentUserImageUrlProvider = StateNotifierProvider<
    GetCuttentUserImageUrlNotifier,
    GetCuttentUserImageUrlState>((ref) => GetCuttentUserImageUrlNotifier());

final getTheProfileOfAnotherUserProvider = StateNotifierProvider<
        GetTheProfileOfAnotherUserNotifier, GetTheProfileOfAnotherUserState>(
    (ref) => GetTheProfileOfAnotherUserNotifier());

// must be auto dispose as it has additional internal state besides the original
// state
final getOwnedPhonesProvider = StateNotifierProvider.autoDispose<
    GetMyOwnedPhonesNotifier,
    GetMyOwnedPhonesState>((ref) => GetMyOwnedPhonesNotifier());

final updateTargetsFromSourceProvider = StateNotifierProvider.autoDispose<
    UpdateTargetsFromSourceNotifier,
    UpdateTargetsFromSourceState>((ref) => UpdateTargetsFromSourceNotifier());

final getInfoAboutLatestUpdateProvider = StateNotifierProvider.autoDispose<
    GetInfoAboutLatestUpdateNotifier,
    GetInfoAboutLatestUpdateState>((ref) => GetInfoAboutLatestUpdateNotifier());

final getMyRecentSearchesProvider = StateNotifierProvider.autoDispose<
    GetMyRecentSearchesNotifier,
    GetMyRecentSearchesState>((ref) => GetMyRecentSearchesNotifier());

final addNewRecentSearchProvider =
    StateNotifierProvider<AddNewRecentSearchNotifier, AddNewRecentSearchState>(
        (ref) => AddNewRecentSearchNotifier());

final deleteRecentSearchProvider = StateNotifierProvider.autoDispose<
    DeleteRecentSearchNotifier,
    DeleteRecentSearchState>((ref) => DeleteRecentSearchNotifier(ref));

final searchProductsAndCompaiesProvider = StateNotifierProvider.autoDispose<
        SearchProductsAndCompaiesNotifier, SearchProductsAndCompaiesState>(
    (ref) => SearchProductsAndCompaiesNotifier());

final getAllCompaniesProvider = StateNotifierProvider.autoDispose<
    GetAllCompaniesNotifier,
    GetAllCompaniesState>((ref) => GetAllCompaniesNotifier());

final getAllPhonesProvider =
    StateNotifierProvider.autoDispose<GetAllPhonesNotifier, GetAllPhonesState>(
        (ref) => GetAllPhonesNotifier());

@Deprecated('Use [getAllPhonesProvider] instead')
final getPhonesFromCertainCompanyProvider = StateNotifierProvider.autoDispose<
        GetPhonesFromCertainCompanyNotifier, GetPhonesFromCertainCompanyState>(
    (ref) => GetPhonesFromCertainCompanyNotifier());

final getTwoPhonesSpecsProvider = StateNotifierProvider.autoDispose<
    GetTwoPhonesSpecsNotifier,
    GetTwoPhonesSpecsState>((ref) => GetTwoPhonesSpecsNotifier());

final getPhoneSpecsProvider = StateNotifierProvider.autoDispose<
    GetPhoneSpecsNotifier,
    GetPhoneSpecsState>((ref) => GetPhoneSpecsNotifier());

final getPhoneStatisticalInfoProvider = StateNotifierProvider.autoDispose<
    GetPhoneStatisticalInfoNotifier,
    GetPhoneStatisticalInfoState>((ref) => GetPhoneStatisticalInfoNotifier());

final indicateUserComparedBetweenTwoPhonesProvider =
    StateNotifierProvider.autoDispose<
            IndicateUserComparedBetweenTwoPhonesNotifier,
            IndicateUserComparedBetweenTwoPhonesState>(
        (ref) => IndicateUserComparedBetweenTwoPhonesNotifier());

final getSimilarPhonesProvider = StateNotifierProvider.autoDispose<
    GetSimilarPhonesNotifier,
    GetSimilarPhonesState>((ref) => GetSimilarPhonesNotifier());

final getPhoneReviewProvider = StateNotifierProvider.autoDispose<
    GetPhoneReviewNotifier,
    GetPhoneReviewState>((ref) => GetPhoneReviewNotifier());

final getCompanyReviewProvider = StateNotifierProvider.autoDispose<
    GetCompanyReviewNotifier,
    GetCompanyReviewState>((ref) => GetCompanyReviewNotifier());

final userImageFetchedFlagProvider = StateProvider<bool>((ref) {
  return false;
});

final userImageUrlProvider = Provider<String>((ref) {
  final state = ref.watch(getMyProfileProvider);
  if (state is GetMyProfileLoadedState) {
    return state.user.picture!;
  } else {
    return StringsManager.imagePlaceHolder;
  }
});

extension WidgetRefListeners on WidgetRef {
  void addErrorListener({
    required ProviderListenable<RequestState> provider,
    required BuildContext context,
    PagingController? controller,
  }) {
    listen<RequestState>(provider, (previous, next) {
      // if an error occurred duting next round, do not show snackbars
      bool nextRoundError = controller != null && controller.itemList != null;
      if (nextRoundError) return;
      // show snackbars otherwise
      showSnackBarWithoutActionAtError(state: next, context: context);
    });
  }

  /// Used in screens containing infinite scrolling lists. Adds a listener to
  /// the received [provider] so that when its state is [LoadedState], the
  /// current items in the [LoadedState] are assigned to the items of the list
  /// that we posses its [controller].
  ///
  /// It also checks to see if rounds ended in the current [LoadedState], it
  /// sets the itemsList of the [PagingController] to null to stop requesting
  /// new pages.
  ///
  /// It also set the error in the [PagingController] so that the corresponding
  /// error widget in the list shows.
  void addInfiniteScrollingListener<T>(
    ProviderListenable<RequestState> provider,
    PagingController<int, T> controller,
  ) {
    listen<RequestState>(provider, (previous, next) {
      // show error widgets in case of errors
      if (next is ErrorState) {
        controller.error = 1;
      } else {
        controller.error = null;
      }
      if (next is LoadedState && next is InfiniteScrollingState<T>) {
        bool roundsEnded = (next as InfiniteScrollingState<T>).roundsEnded;
        if (roundsEnded) {
          controller.itemList ??= <T>[];
          controller.nextPageKey = null;
          return;
        }
        List<T> items =
            (next as InfiniteScrollingState<T>).infiniteScrollingItems;
        controller.itemList = items;
      }
    });
  }

  /// Return partial error widget put into infinite scrolling lists.
  Widget partialErrorWidget({
    required ProviderListenable provider,
    required VoidCallback onRetry,
    required PagingController? controller,
  }) {
    final state = watch(provider);
    if (state is ErrorState) {
      return PartialErrorWidget(
        onRetry: () {
          onRetry();
          controller?.retryLastFailedRequest();
        },
        retryLastRequest: state.failure is RetryFailure,
      );
    } else {
      return SizedBox();
    }
  }

  
}

