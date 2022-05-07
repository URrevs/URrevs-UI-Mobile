import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';

import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/utils/no_glowing_scroll_behavior.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_list_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/fullscreen_error_widget.dart';
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
  late PagingController<int, PhoneReview> _myPhoneReviewsController;
  late PagingController<int, CompanyReview> _myCompanyReviewsController;
  late PagingController<int, PhoneReview> _otherUserPhoneReviewsController;
  late PagingController<int, CompanyReview> _otherUserCompanyReviewsController;

  bool get isMine => widget.screenArgs.userId == null;

  String get appBarTitle =>
      isMine ? LocaleKeys.myReviews.tr() : LocaleKeys.tabBarReview.tr();

  void setFilter(ReviewsFilter filter) {
    ref.refresh(getMyPhoneReviewsProvider);
    ref.refresh(getMyCompanyReviewsProvider);
    ref.refresh(getPhoneReviewsOfAnotherUserProvider);
    ref.refresh(getCompanyReviewsOfAnotherUserProvider);
    _myPhoneReviewsController.refresh();
    _myCompanyReviewsController.refresh();
    _otherUserPhoneReviewsController.refresh();
    _otherUserCompanyReviewsController.refresh();
    setState(() => _filter = filter);
  }

  void _getMyPhoneReviews() {
    _myPhoneReviewsController.retryLastFailedRequest();
    ref.read(getMyPhoneReviewsProvider.notifier).getMyPhoneReviews();
  }

  void _getMyCompanyReviews() {
    _myCompanyReviewsController.retryLastFailedRequest();
    ref.read(getMyCompanyReviewsProvider.notifier).getMyCompanyReviews();
  }

  void _getPhoneReviewsOfAnotherUser() {
    if (!isMine) {
      _otherUserPhoneReviewsController.retryLastFailedRequest();
      ref
          .read(getPhoneReviewsOfAnotherUserProvider.notifier)
          .getPhoneReviewsOfAnotherUser(widget.screenArgs.userId!);
    }
  }

  void _getCompanyReviewsOfAnotherUser() {
    if (!isMine) {
      _otherUserCompanyReviewsController.retryLastFailedRequest();
      ref
          .read(getCompanyReviewsOfAnotherUserProvider.notifier)
          .getCompanyReviewsOfAnotherUser(widget.screenArgs.userId!);
    }
  }

  @override
  void initState() {
    super.initState();
    _myPhoneReviewsController = PagingController(firstPageKey: 0)
      ..addPageRequestListener((_) {
        Future.delayed(Duration.zero, _getMyPhoneReviews);
      });
    _myCompanyReviewsController = PagingController(firstPageKey: 0)
      ..addPageRequestListener((_) {
        Future.delayed(Duration.zero, _getMyCompanyReviews);
      });
    _otherUserPhoneReviewsController = PagingController(firstPageKey: 0)
      ..addPageRequestListener((_) {
        Future.delayed(Duration.zero, _getPhoneReviewsOfAnotherUser);
      });
    _otherUserCompanyReviewsController = PagingController(firstPageKey: 0)
      ..addPageRequestListener((_) {
        Future.delayed(Duration.zero, _getCompanyReviewsOfAnotherUser);
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
    final myPhoneReviewsState = ref.watch(getMyPhoneReviewsProvider);
    final myCompanyReviewsState = ref.watch(getMyCompanyReviewsProvider);
    Widget? widget = fullScreenErrorWidgetOrNull(
      [
        StateAndRetry(state: myPhoneReviewsState, onRetry: _getMyPhoneReviews),
        StateAndRetry(
          state: myCompanyReviewsState,
          onRetry: _getMyCompanyReviews,
        ),
        StateAndRetry(
          state: ref.watch(getPhoneReviewsOfAnotherUserProvider),
          onRetry: _getPhoneReviewsOfAnotherUser,
        ),
        StateAndRetry(
          state: ref.watch(getCompanyReviewsOfAnotherUserProvider),
          onRetry: _getCompanyReviewsOfAnotherUser,
        ),
      ],
      retryOtherFailedRequests: false,
    );
    if (widget != null) return widget;
    return CustomScrollView(
      slivers: [
        _buildFilterBar(),
        _chooseBetweenLists(),
      ],
    );
  }

  Widget _chooseBetweenLists() {
    if (widget.screenArgs.userId == null) {
      if (_filter == ReviewsFilter.phones) {
        return _buildPhoneReviewsList();
      } else {
        return _buildMyCompanyReviewsList();
      }
    } else {
      if (_filter == ReviewsFilter.phones) {
        return _buildOtherUserPhoneReviewsList();
      } else {
        return _buildOtherUserCompanyReviewsList();
      }
    }
  }

  Widget _buildPhoneReviewsList() {
    ref.addErrorListener(provider: getMyPhoneReviewsProvider, context: context);
    ref.addInfiniteScrollingListener(
      getMyPhoneReviewsProvider,
      _myPhoneReviewsController,
    );
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      sliver: PagedSliverList(
        pagingController: _myPhoneReviewsController,
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
            return ref.partialErrorWidget(
              controller: _myPhoneReviewsController,
              provider: getAllPhonesProvider,
              onRetry: _getMyPhoneReviews,
            );
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
        provider: getMyCompanyReviewsProvider, context: context);
    ref.addInfiniteScrollingListener(
      getMyCompanyReviewsProvider,
      _myCompanyReviewsController,
    );
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      sliver: PagedSliverList<int, CompanyReview>(
        pagingController: _myCompanyReviewsController,
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
            return ref.partialErrorWidget(
              controller: _myCompanyReviewsController,
              provider: getMyCompanyReviewsProvider,
              onRetry: _getMyCompanyReviews,
            );
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

  Widget _buildOtherUserPhoneReviewsList() {
    ref.addErrorListener(
      provider: getPhoneReviewsOfAnotherUserProvider,
      context: context,
    );
    ref.addInfiniteScrollingListener(
      getPhoneReviewsOfAnotherUserProvider,
      _otherUserPhoneReviewsController,
    );
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      sliver: PagedSliverList(
        pagingController: _otherUserPhoneReviewsController,
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
            return ref.partialErrorWidget(
              controller: _otherUserPhoneReviewsController,
              provider: getPhoneReviewsOfAnotherUserProvider,
              onRetry: _getPhoneReviewsOfAnotherUser,
            );
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

  Widget _buildOtherUserCompanyReviewsList() {
    ref.addErrorListener(
        provider: getCompanyReviewsOfAnotherUserProvider, context: context);
    ref.addInfiniteScrollingListener(
      getCompanyReviewsOfAnotherUserProvider,
      _otherUserCompanyReviewsController,
    );
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      sliver: PagedSliverList<int, CompanyReview>(
        pagingController: _otherUserCompanyReviewsController,
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
            return ref.partialErrorWidget(
              controller: _otherUserCompanyReviewsController,
              provider: getCompanyReviewsOfAnotherUserProvider,
              onRetry: _getCompanyReviewsOfAnotherUser,
            );
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
