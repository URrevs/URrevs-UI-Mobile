import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/models/quesiton.dart';
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
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

import '../../../resources/text_style_manager.dart';

class PostedReviewsScreenArgs {
  String? userId;
  PostContentType postContentType;
  PostedReviewsScreenArgs(
      {required this.userId, required this.postContentType});

  static PostedReviewsScreenArgs get defaultArgs => PostedReviewsScreenArgs(
      userId: null, postContentType: PostContentType.review);
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
  TargetType _filter = TargetType.phone;
  late final PagingController<int, Post> _postsController =
      PagingController(firstPageKey: 0)
        ..addPageRequestListener((_) {
          Future.delayed(Duration.zero, _getPosts);
        });

  late final String? _userId = widget.screenArgs.userId;
  late final PostContentType _postContentType =
      widget.screenArgs.postContentType;

  late final GetUserPostsProviderParams _postsProviderParams =
      GetUserPostsProviderParams(
          userId: _userId, postContentType: _postContentType);

  bool get isMine => widget.screenArgs.userId == null;

  String get appBarTitle {
    if (_postContentType == PostContentType.review) {
      return isMine ? LocaleKeys.myReviews.tr() : LocaleKeys.tabBarReview.tr();
    } else {
      return isMine
          ? LocaleKeys.myQuestions.tr()
          : LocaleKeys.tabBarQuestion.tr();
    }
  }

  String get fabLabel => _postContentType == PostContentType.review
      ? LocaleKeys.addReview.tr()
      : LocaleKeys.addQuestion.tr();

  void setFilter(TargetType filter) {
    setState(() => _filter = filter);
    ref.refresh(getUserpostsProvider(_postsProviderParams));
    _postsController.refresh();
  }

  void _getPosts() {
    _postsController.retryLastFailedRequest();
    ref
        .read(getUserpostsProvider(_postsProviderParams).notifier)
        .getUserPosts(_filter);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      onPressingFab: () {},
      fabLabel: fabLabel,
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
    final postsState = ref.watch(getUserpostsProvider(_postsProviderParams));
    Widget? errWidget = fullScreenErrorWidgetOrNull(
      [
        StateAndRetry(
          state: postsState,
          onRetry: _getPosts,
          controller: _postsController,
        ),
      ],
      retryOtherFailedRequests: false,
    );
    if (errWidget != null) return errWidget;
    return CustomScrollView(
      slivers: [
        _buildFilterBar(),
        _buildPostsList(),
      ],
    );
  }

  Widget _buildPost(Post post) {
    if (post is Question) {
      Question question = post;
      CardType cardType = _filter == TargetType.phone
          ? CardType.productQuestion
          : CardType.companyQuestion;
      PostType postType = _filter == TargetType.phone
          ? PostType.phoneQuestion
          : PostType.companyQuestion;
      return QuestionCard.fromQuestion(
        question,
        cardHeaderTitleType: _filter,
        cardType: cardType,
        fullscreen: false,
        onPressingAnswer: () {
          Navigator.of(context).pushNamed(
            FullscreenPostScreen.routeName,
            arguments: FullscreenPostScreenArgs(
              postType: postType,
              cardType: cardType,
              postId: 'change_it',
              focusOnTextField: true,
            ),
          );
        },
      );
    }
    // phone reviews
    if (post is PhoneReview) {
      PhoneReview phoneReview = post;
      return ProductReviewCard.fromPhoneReview(
        phoneReview: phoneReview,
        fullscreen: false,
        onPressingComment: () {
          Navigator.of(context).pushNamed(
            FullscreenPostScreen.routeName,
            arguments: FullscreenPostScreenArgs(
              postType: PostType.phoneReview,
              cardType: CardType.productReview,
              postId: phoneReview.id,
              focusOnTextField: true,
            ),
          );
        },
      );
    }
    // company reviews
    CompanyReview companyReview = post as CompanyReview;
    return CompanyReviewCard.fromCompanyReview(
      companyReview: companyReview,
      fullscreen: false,
      onPressingComment: () {
        Navigator.of(context).pushNamed(
          FullscreenPostScreen.routeName,
          arguments: FullscreenPostScreenArgs(
            postType: PostType.companyReview,
            cardType: CardType.companyReview,
            postId: companyReview.id,
            focusOnTextField: true,
          ),
        );
      },
    );
  }

  Widget _buildPostsList() {
    ref.addErrorListener(
      provider: getUserpostsProvider(_postsProviderParams),
      context: context,
      controller: _postsController,
    );
    ref.addInfiniteScrollingListener(
      getUserpostsProvider(_postsProviderParams),
      _postsController,
    );
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      sliver: PagedSliverList(
        pagingController: _postsController,
        builderDelegate: PagedChildBuilderDelegate<Post>(
          itemBuilder: (context, post, index) => _buildPost(post),
          firstPageErrorIndicatorBuilder: (context) => SizedBox(),
          newPageErrorIndicatorBuilder: (context) {
            final state = ref.watch(getUserpostsProvider(_postsProviderParams));
            if (state is ErrorState) {
              return VerticalListErrorWidget(
                onRetry: _getPosts,
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
              backgroundColor: _filter == TargetType.phone
                  ? MaterialStateProperty.all<Color>(ColorManager.buttonGrey)
                  : MaterialStateProperty.all<Color>(ColorManager.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                  side: BorderSide(color: ColorManager.buttonGrey),
                ),
              ),
            ),
            onPressed: () => setFilter(TargetType.phone),
            child: Text(
              LocaleKeys.phones.tr(),
              style: TextStyleManager.s14w700.copyWith(
                color: _filter == TargetType.phone
                    ? ColorManager.white
                    : ColorManager.buttonGrey,
              ),
            ),
          ),
          SizedBox(width: 17.w),
          TextButton(
            style: ButtonStyle(
              backgroundColor: _filter == TargetType.company
                  ? MaterialStateProperty.all<Color>(ColorManager.buttonGrey)
                  : MaterialStateProperty.all<Color>(ColorManager.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                  side: BorderSide(color: ColorManager.buttonGrey),
                ),
              ),
            ),
            onPressed: () => setFilter(TargetType.company),
            child: Text(
              LocaleKeys.companies.tr(),
              style: TextStyleManager.s14w700.copyWith(
                color: _filter == TargetType.company
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
