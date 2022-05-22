import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/authentication_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/companies_notifiers/get_all_companies_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/get_current_user_image_url_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/get_info_about_latest_update_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/get_my_owned_phones_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/get_my_profile_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/leaderboard_notifiers/add_competition_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/phones_notifier/get_all_phones_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/phones_notifier/get_two_phones_specs_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/search_notifiers/add_new_recent_search_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/search_notifiers/delete_recent_search_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/search_notifiers/get_my_recent_searches_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/get_the_profile_of_another_user.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/give_points_to_user_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/search_notifiers/search_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/simple_state_notifiers/direct_interactions_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/simple_state_notifiers/like_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/simple_state_notifiers/post_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/simple_state_notifiers/reply_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/theme_mode_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/update_targets_from_source_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/companies_states/get_all_companies_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/companies_states/get_company_statistical_info_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_current_user_image_url_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_info_about_latest_update_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_owned_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/leaderboard_states/add_compeititon_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_all_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_phone_specs_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_phone_statistical_info_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_phones_from_certain_company_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_similar_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_two_phones_specs_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/indicate_user_compared_between_two_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/question_states/accept_answer_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/question_states/add_question_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/question_states/get_post_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/add_interaction_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/add_phone_review_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/add_review_reply_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_interactions_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_phone_manufacturing_company_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_reviews_on_certain_phone_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_posts_list_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/i_dont_like_this_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/like_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/add_new_recent_search_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/delete_recent_search_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/get_my_recent_searches_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_user_profile_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_the_profile_of_another_user_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/give_points_to_user_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/search_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/update_targets_from_source_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/partial_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/reply.dart';

import 'notifiers/companies_notifiers/get_company_statistical_info_notifier.dart';
import 'notifiers/phones_notifier/get_phone_specs_notifier.dart';
import 'notifiers/phones_notifier/get_phones_from_certain_company_notifier.dart';
import 'notifiers/phones_notifier/get_similar_phones_notifier.dart';
import 'notifiers/phones_notifier/indicate_user_compared_between_two_phones_notifier.dart';
import 'notifiers/questions_notifiers/accept_answer_notifier.dart';
import 'notifiers/questions_notifiers/add_question_notifier.dart';
import 'notifiers/questions_notifiers/get_post_notifier.dart';
import 'notifiers/reviews_notifiers/add_interaction_notifier.dart';
import 'notifiers/reviews_notifiers/add_phone_review_notifier.dart';
import 'notifiers/reviews_notifiers/add_review_reply_notifier.dart';
import 'notifiers/reviews_notifiers/get_interactions_notifier.dart';
import 'notifiers/reviews_notifiers/get_phone_manufacturing_company_notifier.dart';
import 'notifiers/reviews_notifiers/get_reviews_on_certain_phone_notifier.dart';
import 'notifiers/reviews_notifiers/get_posts_list_notifier.dart';
import 'notifiers/reviews_notifiers/i_dont_like_this_notifier.dart';
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
    StateNotifierProvider.autoDispose<GetMyProfileNotifier, GetMyProfileState>(
        (ref) => GetMyProfileNotifier());

final getTheProfileOfAnotherUserProvider = StateNotifierProvider.autoDispose
    .family<GetTheProfileOfAnotherUserNotifier, GetTheProfileOfAnotherUserState,
            GetTheProfileOfAnotherUserProviderParams>(
        (ref, params) => GetTheProfileOfAnotherUserNotifier());

final getOwnedPhonesProvider = StateNotifierProvider.autoDispose.family<
        GetOwnedPhonesNotifier,
        GetOwnedPhonesState,
        GetOwnedPhonesProviderParams>(
    (ref, params) => GetOwnedPhonesNotifier(userId: params.userId));

final updateTargetsFromSourceProvider = StateNotifierProvider.autoDispose<
    UpdateTargetsFromSourceNotifier,
    UpdateTargetsFromSourceState>((ref) => UpdateTargetsFromSourceNotifier());

final getInfoAboutLatestUpdateProvider = StateNotifierProvider.autoDispose
    .family<GetInfoAboutLatestUpdateNotifier, GetInfoAboutLatestUpdateState,
            GetInfoAboutLatestUpdateProviderParams>(
        (ref, params) => GetInfoAboutLatestUpdateNotifier());

final getMyRecentSearchesProvider = StateNotifierProvider.autoDispose<
    GetMyRecentSearchesNotifier,
    GetMyRecentSearchesState>((ref) => GetMyRecentSearchesNotifier());

final addNewRecentSearchProvider =
    StateNotifierProvider<AddNewRecentSearchNotifier, AddNewRecentSearchState>(
        (ref) => AddNewRecentSearchNotifier());

final deleteRecentSearchProvider = StateNotifierProvider.autoDispose<
    DeleteRecentSearchNotifier,
    DeleteRecentSearchState>((ref) => DeleteRecentSearchNotifier(ref));

final searchProvider = StateNotifierProvider.autoDispose
    .family<SearchNotifier, SearchState, SearchProviderParams>(
        (ref, params) => SearchNotifier(searchMode: params.searchMode));

final getCompanyStatisticalInfoProvider = StateNotifierProvider.autoDispose
    .family<GetCompanyStatisticalInfoNotifier, GetCompanyStatisticalInfoState,
            GetCompanyStatisticalInfoProviderParams>(
        (ref, params) => GetCompanyStatisticalInfoNotifier());

final getAllCompaniesProvider = StateNotifierProvider.autoDispose.family<
    GetAllCompaniesNotifier,
    GetAllCompaniesState,
    GetAllCompaniesProviderParams>((ref, params) => GetAllCompaniesNotifier());

final getAllPhonesProvider = StateNotifierProvider.autoDispose.family<
    GetAllPhonesNotifier,
    GetAllPhonesState,
    GetAllPhonesProviderParams>((ref, params) => GetAllPhonesNotifier());

final getTwoPhonesSpecsProvider = StateNotifierProvider.autoDispose.family<
        GetTwoPhonesSpecsNotifier,
        GetTwoPhonesSpecsState,
        GetTwoPhonesSpecsProviderParams>(
    (ref, params) => GetTwoPhonesSpecsNotifier());

final getPhoneSpecsProvider = StateNotifierProvider.autoDispose.family<
    GetPhoneSpecsNotifier,
    GetPhoneSpecsState,
    GetPhoneSpecsProviderParams>((ref, params) => GetPhoneSpecsNotifier());

final getPhoneStatisticalInfoProvider = StateNotifierProvider.autoDispose
    .family<GetPhoneStatisticalInfoNotifier, GetPhoneStatisticalInfoState,
            GetPhoneStatisticalInfoProviderParams>(
        (ref, params) => GetPhoneStatisticalInfoNotifier());

final indicateUserComparedBetweenTwoPhonesProvider =
    StateNotifierProvider.autoDispose<
            IndicateUserComparedBetweenTwoPhonesNotifier,
            IndicateUserComparedBetweenTwoPhonesState>(
        (ref) => IndicateUserComparedBetweenTwoPhonesNotifier());

final getSimilarPhonesProvider = StateNotifierProvider.autoDispose.family<
        GetSimilarPhonesNotifier,
        GetSimilarPhonesState,
        GetSimilarPhonesProviderParams>(
    (ref, params) => GetSimilarPhonesNotifier());

// final getMyPhoneReviewsProvider = StateNotifierProvider.autoDispose<
//     GetMyPhoneReviewsNotifier,
//     GetMyPhoneReviewsState>((ref) => GetMyPhoneReviewsNotifier());

// final getPhoneReviewsOfAnotherUserProvider = StateNotifierProvider.autoDispose
//     .family<
//             GetPhoneReviewsOfAnotherUserNotifier,
//             GetPhoneReviewsOfAnotherUserState,
//             GetUserPhoneReviewsProviderParams>(
//         (ref, params) => GetPhoneReviewsOfAnotherUserNotifier());

// final getMyCompanyReviewsProvider = StateNotifierProvider.autoDispose<
//     GetMyCompanyReviewsNotifier,
//     GetMyCompanyReviewsState>((ref) => GetMyCompanyReviewsNotifier());

// final getCompanyReviewsOfAnotherUserProvider =
//     StateNotifierProvider.autoDispose<GetCompanyReviewsOfAnotherUserNotifier,
//             GetCompanyReviewsOfAnotherUserState>(
//         (ref) => GetCompanyReviewsOfAnotherUserNotifier());

final getPostsListProvider = StateNotifierProvider.autoDispose.family<
        GetPostsListNotifier, GetPostsListState, GetPostsListProviderParams>(
    (ref, params) => GetPostsListNotifier(ref: ref));

final getReviewsOnCertainPhoneProvider = StateNotifierProvider.autoDispose
    .family<GetReviewsOnCertainPhoneNotifier, GetReviewsOnCertainPhoneState,
            GetReviewsOnCertainPhoneProviderParams>(
        (ref, params) =>
            GetReviewsOnCertainPhoneNotifier(phoneId: params.phoneId));

final likeProvider = StateNotifierProvider.autoDispose
    .family<LikeNotifier, LikeState, LikeProviderParams>((ref, params) {
  return LikeNotifier(
    socialItemId: params.socialItemId,
    replyParentId: params.replyParentId,
    postType: params.postType,
    interactionType: params.interactionType,
    ref: ref,
    getInteractionsProviderParams: params.getInteractionsProviderParams,
  );
});

final getInteractionsProvider = StateNotifierProvider.autoDispose.family<
        GetInteractionsNotifier,
        GetInteractionsState,
        GetInteractionsProviderParams>(
    (ref, params) => GetInteractionsNotifier(
        postId: params.postId, postType: params.postType, ref: ref));

final addInteractionProvider = StateNotifierProvider.autoDispose.family<
        AddInteractionNotifier,
        AddInteractionState,
        AddInteractionProviderParams>(
    (ref, params) => AddInteractionNotifier(
        postId: params.postId, postType: params.postType, ref: ref));

final getPhoneManufacturingCompanyProvider = StateNotifierProvider.autoDispose
    .family<
            GetPhoneManufacturingCompanyNotifier,
            GetPhoneManufacturingCompanyState,
            GetPhoneManufacturingCompanyProviderParams>(
        (ref, params) => GetPhoneManufacturingCompanyNotifier());

final addPhoneReviewProvider = StateNotifierProvider.autoDispose.family<
    AddPhoneReviewNotifier,
    AddPhoneReviewState,
    AddPhoneReviewProviderParams>((ref, params) => AddPhoneReviewNotifier());

final addQuestionProvider =
    StateNotifierProvider.autoDispose<AddQuestionNotifier, AddQuestionState>(
        (ref) => AddQuestionNotifier());

final getPostProvider = StateNotifierProvider.autoDispose
    .family<GetPostNotifier, GetPostState, GetPostProviderParams>(
        (ref, params) =>
            GetPostNotifier(postId: params.postId, postType: params.postType));

final acceptAnswerProvider = StateNotifierProvider.autoDispose.family<
        AcceptAnswerNotifier, AcceptAnswerState, AcceptAnswerProviderParams>(
    (ref, params) => AcceptAnswerNotifier(
          ref: ref,
          answerId: params.answerId,
          questionId: params.questionId,
          targetType: params.targetType,
          getInteractionsProviderParams: params.getInteractionsProviderParams,
        ));

final iDontLikeThisProvider = StateNotifierProvider.autoDispose.family<
        IDontLikeThisNotifier, IDontLikeThisState, IDontLikeThisProviderParams>(
    (ref, params) => IDontLikeThisNotifier(
        postId: params.postId,
        postContentType: params.postContentType,
        targetType: params.targetType));

final addCompetitionProvider = StateNotifierProvider.autoDispose<
    AddCompetitionNotifier,
    AddCompetitionState>((ref) => AddCompetitionNotifier());

// posts and interactions providers

final postProvider = StateNotifierProvider.autoDispose
    .family<PostNotifier, Post, PostProviderParams>((ref, params) {
  return PostNotifier(post: params.post);
});
final directInteractionsProvider = StateNotifierProvider.autoDispose.family<
    DirectInteractionNotifier,
    DirectInteraction,
    DirectInteractionProviderParams>((ref, params) {
  return DirectInteractionNotifier(interaction: params.interaction);
});
final replyProvider = StateNotifierProvider.autoDispose
    .family<ReplyNotifier, ReplyModel, ReplyProviderParams>((ref, params) {
  return ReplyNotifier(reply: params.reply);
});

extension WidgetRefListeners on WidgetRef {
  void addErrorListener({
    required ProviderListenable<RequestState> provider,
    required BuildContext context,
    PagingController? controller,
    EdgeInsets? margin,
  }) {
    listen<RequestState>(provider, (previous, next) {
      // if an error occurred duting next round, do not show snackbars
      bool nextRoundError = controller != null && controller.itemList != null;
      if (nextRoundError) return;
      // show snackbars otherwise
      showSnackBarWithoutActionAtError(
        state: next,
        context: context,
        margin: margin,
      );
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

  User? get currentUser {
    final authState = watch(authenticationProvider);
    if (authState is! AuthenticationLoadedState) return null;
    return authState.user;
  }
}
