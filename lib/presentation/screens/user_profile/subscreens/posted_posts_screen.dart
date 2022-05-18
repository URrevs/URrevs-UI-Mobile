import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';

import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/utils/no_glowing_scroll_behavior.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/posts_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

import '../../../resources/text_style_manager.dart';

class PostedPostsScreenArgs {
  String? userId;
  PostContentType postContentType;
  PostedPostsScreenArgs({required this.userId, required this.postContentType});

  static PostedPostsScreenArgs get defaultArgs => PostedPostsScreenArgs(
      userId: null, postContentType: PostContentType.review);
}

class PostedPostsScreen extends ConsumerStatefulWidget {
  const PostedPostsScreen(this.screenArgs, {Key? key}) : super(key: key);

  final PostedPostsScreenArgs screenArgs;

  static const String routeName = 'PostedPostsScreen';

  @override
  ConsumerState<PostedPostsScreen> createState() => _PostedReviewsScreenState();
}

class _PostedReviewsScreenState extends ConsumerState<PostedPostsScreen> {
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
        SliverPostsList(
          controller: _postsController,
          getPosts: _getPosts,
          getUserPostsProviderParams: _postsProviderParams,
          targetType: _filter,
        ),
      ],
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
