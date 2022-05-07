import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';

import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/utils/no_glowing_scroll_behavior.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_list_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/vertical_list_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/review_card_list_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

import '../../../resources/text_style_manager.dart';

class PostedReviewsScreenArgs {
  String? userId;
  PostedReviewsScreenArgs({
    required this.userId,
  });

  static PostedReviewsScreenArgs get defaultArgs =>
      PostedReviewsScreenArgs(userId: null);
}

class PostedReviewsScreen extends ConsumerStatefulWidget {
  const PostedReviewsScreen(this.screenArgs, {Key? key}) : super(key: key);

  final PostedReviewsScreenArgs screenArgs;

  static const String routeName = 'PostedReviewsScreen';

  @override
  ConsumerState<PostedReviewsScreen> createState() =>
      _PostedReviewsScreenState();
}

class _PostedReviewsScreenState extends ConsumerState<PostedReviewsScreen> {
  ReviewsFilter _filter = ReviewsFilter.phones;
  late PagingController<int, PhoneReview> _phoneReviewsController;
  late PagingController<int, CompanyReview> _companyReviewsController;

  late final String? _userId = widget.screenArgs.userId;

  late final GetUserPhoneReviewsProviderParams _phoneProviderParams =
      GetUserPhoneReviewsProviderParams(userId: _userId);

  late final GetUserCompanyReviewsProviderParams _companyProviderParams =
      GetUserCompanyReviewsProviderParams(userId: _userId);

  bool get isMine => widget.screenArgs.userId == null;

  String get appBarTitle =>
      isMine ? LocaleKeys.myReviews.tr() : LocaleKeys.tabBarReview.tr();

  void setFilter(ReviewsFilter filter) {
    ref.refresh(getUserPhoneReviewsProvider(_phoneProviderParams));
    ref.refresh(getUserCompanyReviewsProvider(_companyProviderParams));
    _phoneReviewsController.refresh();
    _companyReviewsController.refresh();
    setState(() => _filter = filter);
  }

  void _getPhoneReviews() {
    _phoneReviewsController.retryLastFailedRequest();
    ref
        .read(getUserPhoneReviewsProvider(_phoneProviderParams).notifier)
        .getUserPhoneReviews();
  }

  void _getCompanyReviews() {
    _companyReviewsController.retryLastFailedRequest();
    ref
        .read(getUserCompanyReviewsProvider(_companyProviderParams).notifier)
        .getUserCompanyReviews();
  }

  @override
  void initState() {
    super.initState();
    _phoneReviewsController = PagingController(firstPageKey: 0)
      ..addPageRequestListener((_) {
        Future.delayed(Duration.zero, _getPhoneReviews);
      });
    _companyReviewsController = PagingController(firstPageKey: 0)
      ..addPageRequestListener((_) {
        Future.delayed(Duration.zero, _getCompanyReviews);
      });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      onPressingFab: () {},
      fabLabel: LocaleKeys.addReview.tr(),
      fabIcon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      appBar: AppBars.appBarWithTitle(
          context: context, title: appBarTitle, elevation: 1),
      body: ScrollConfiguration(
        behavior: NoGlowingScrollBehaviour(),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final phoneReviewsState =
        ref.watch(getUserPhoneReviewsProvider(_phoneProviderParams));
    final companyReviewsState =
        ref.watch(getUserCompanyReviewsProvider(_companyProviderParams));

    Widget? errWidget = fullScreenErrorWidgetOrNull(
      [
        StateAndRetry(
          state: phoneReviewsState,
          onRetry: _getPhoneReviews,
          controller: _phoneReviewsController,
        ),
        StateAndRetry(
          state: companyReviewsState,
          onRetry: _getCompanyReviews,
          controller: _companyReviewsController,
        ),
      ],
      retryOtherFailedRequests: false,
    );
    if (errWidget != null) return errWidget;
    return CustomScrollView(
      slivers: [
        _buildFilterBar(),
        _chooseBetweenLists(),
      ],
    );
  }

  Widget _chooseBetweenLists() {
    if (_filter == ReviewsFilter.phones) {
      return _buildPhoneReviewsList();
    } else {
      return _buildMyCompanyReviewsList();
    }
  }

  Widget _buildPhoneReviewsList() {
    ref.addErrorListener(
      provider: getUserPhoneReviewsProvider(_phoneProviderParams),
      context: context,
      controller: _phoneReviewsController,
    );
    ref.addInfiniteScrollingListener(
      getUserPhoneReviewsProvider(_phoneProviderParams),
      _phoneReviewsController,
    );
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      sliver: PagedSliverList(
        pagingController: _phoneReviewsController,
        builderDelegate: PagedChildBuilderDelegate<PhoneReview>(
          itemBuilder: (context, phoneReview, index) {
            return ProductReviewCard.fromPhoneReview(
              phoneReview: phoneReview,
              fullscreen: true,
              onPressingComment: () {
                Navigator.of(context).pushNamed(
                  FullscreenPostScreen.routeName,
                  arguments: FullscreenPostScreenArgs(
                    cardType: CardType.productReview,
                    postId: phoneReview.id,
                    focusOnTextField: true,
                  ),
                );
              },
            );
          },
          firstPageErrorIndicatorBuilder: (context) => SizedBox(),
          newPageErrorIndicatorBuilder: (context) {
            final state =
                ref.watch(getUserPhoneReviewsProvider(_phoneProviderParams));
            if (state is ErrorState) {
              return VerticalListErrorWidget(
                onRetry: _getPhoneReviews,
                retryLastRequest: (state as ErrorState).failure is RetryFailure,
              );
            } else {
              return SizedBox();
            }
          },
          firstPageProgressIndicatorBuilder: (context) =>
              ReviewCardsListLoading(),
          newPageProgressIndicatorBuilder: (context) =>
              ReviewCardsListLoading(),
          noItemsFoundIndicatorBuilder: (context) => EmptyListWidget(),
        ),
      ),
    );
  }

  Widget _buildMyCompanyReviewsList() {
    ref.addErrorListener(
      provider: getUserCompanyReviewsProvider(_companyProviderParams),
      context: context,
      controller: _companyReviewsController,
    );
    ref.addInfiniteScrollingListener(
      getUserCompanyReviewsProvider(_companyProviderParams),
      _companyReviewsController,
    );
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      sliver: PagedSliverList<int, CompanyReview>(
        pagingController: _companyReviewsController,
        builderDelegate: PagedChildBuilderDelegate<CompanyReview>(
          itemBuilder: (context, companyReview, index) {
            return CompanyReviewCard.fromCompanyReview(
              companyReview: companyReview,
              fullscreen: true,
              onPressingComment: () {
                Navigator.of(context).pushNamed(
                  FullscreenPostScreen.routeName,
                  arguments: FullscreenPostScreenArgs(
                    cardType: CardType.productReview,
                    postId: companyReview.id,
                    focusOnTextField: true,
                  ),
                );
              },
            );
          },
          firstPageErrorIndicatorBuilder: (context) => SizedBox(),
          newPageErrorIndicatorBuilder: (context) {
            final state = ref
                .watch(getUserCompanyReviewsProvider(_companyProviderParams));
            if (state is ErrorState) {
              return VerticalListErrorWidget(
                onRetry: _getCompanyReviews,
                retryLastRequest: (state as ErrorState).failure is RetryFailure,
              );
            } else {
              return SizedBox();
            }
          },
          firstPageProgressIndicatorBuilder: (context) =>
              ReviewCardsListLoading(),
          newPageProgressIndicatorBuilder: (context) =>
              ReviewCardsListLoading(),
          noItemsFoundIndicatorBuilder: (context) => EmptyListWidget(),
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return SliverAppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: ColorManager.white,
      iconTheme: IconThemeData(
        color: ColorManager.black,
      ),
      elevation: 3,
      forceElevated: true,
      snap: true,
      floating: true,
      toolbarHeight: 45.h,
      collapsedHeight: 45.h,
      expandedHeight: 45.h,
      flexibleSpace: Row(
        children: [
          SizedBox(width: 17.w),
          TextButton(
            style: ButtonStyle(
              backgroundColor: _filter == ReviewsFilter.phones
                  ? MaterialStateProperty.all<Color>(ColorManager.buttonGrey)
                  : MaterialStateProperty.all<Color>(ColorManager.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                  side: BorderSide(color: ColorManager.buttonGrey),
                ),
              ),
            ),
            onPressed: () => setFilter(ReviewsFilter.phones),
            child: Text(
              LocaleKeys.phones.tr(),
              style: TextStyleManager.s14w700.copyWith(
                color: _filter == ReviewsFilter.phones
                    ? ColorManager.white
                    : ColorManager.buttonGrey,
              ),
            ),
          ),
          SizedBox(width: 17.w),
          TextButton(
            style: ButtonStyle(
              backgroundColor: _filter == ReviewsFilter.companies
                  ? MaterialStateProperty.all<Color>(ColorManager.buttonGrey)
                  : MaterialStateProperty.all<Color>(ColorManager.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                  side: BorderSide(color: ColorManager.buttonGrey),
                ),
              ),
            ),
            onPressed: () => setFilter(ReviewsFilter.companies),
            child: Text(
              LocaleKeys.companies.tr(),
              style: TextStyleManager.s14w700.copyWith(
                color: _filter == ReviewsFilter.companies
                    ? ColorManager.white
                    : ColorManager.buttonGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
