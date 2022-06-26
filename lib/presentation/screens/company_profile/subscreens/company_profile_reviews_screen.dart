import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/companies_states/get_company_statistical_info_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/rating_overview_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/company_overview_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/posts_list.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class CompanyProfileReviewsSubscreen extends ConsumerStatefulWidget {
  const CompanyProfileReviewsSubscreen({Key? key, required this.companyId})
      : super(key: key);

  final String companyId;

  @override
  ConsumerState<CompanyProfileReviewsSubscreen> createState() =>
      _CompanyProfileReviewsSubscreenState();
}

class _CompanyProfileReviewsSubscreenState
    extends ConsumerState<CompanyProfileReviewsSubscreen> {
  late final PagingController<int, Post> _controller =
      PagingController(firstPageKey: 0)
        ..addPageRequestListener((_) {
          Future.delayed(Duration.zero, _getPostsOnCertainTarget);
        });

  late final GetCompanyStatisticalInfoProviderParams _statsProviderParams =
      GetCompanyStatisticalInfoProviderParams();
  late final GetPostsListProviderParams _postsProviderParams =
      GetPostsListProviderParams();

  void _getCompanyStats() {
    ref
        .read(getCompanyStatisticalInfoProvider(_statsProviderParams).notifier)
        .getCompanyStatisticalInfo(widget.companyId);
  }

  void _getPostsOnCertainTarget() {
    _controller.retryLastFailedRequest();
    ref.read(getPostsListProvider(_postsProviderParams).notifier).getPostsList(
          postsListType: PostsListType.target,
          targetType: TargetType.company,
          postContentType: PostContentType.review,
          targetId: widget.companyId,
          userId: null,
        );
  }

  Widget _buildCompanyOverview() {
    final state =
        ref.watch(getCompanyStatisticalInfoProvider(_statsProviderParams));
    Widget? errOrLoadWidget = loadingOrErrorWidgetOrNull(
      state: state,
      loadingWidget: CompanyOverviewLoading(),
    );
    if (errOrLoadWidget != null) return errOrLoadWidget;
    state as GetCompanyStatisticalInfoLoadedState;
    return RatingOverviewCard(
      productName: state.companyStats.name,
      generalCompanyRating: state.companyStats.rating,
      viewsCounter: state.companyStats.views,
      isProduct: false,
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _getCompanyStats);
  }

  @override
  Widget build(BuildContext context) {
    Widget? errWidget = fullScreenErrorWidgetOrNull([
      StateAndRetry(
        state:
            ref.watch(getCompanyStatisticalInfoProvider(_statsProviderParams)),
        onRetry: _getCompanyStats,
      ),
      StateAndRetry(
        state: ref.watch(getPostsListProvider(_postsProviderParams)),
        onRetry: _getPostsOnCertainTarget,
        controller: _controller,
      ),
    ]);
    if (errWidget != null) return errWidget;
    return Padding(
      padding: AppEdgeInsets.screenWithoutFabHorizontalPadding,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          SliverToBoxAdapter(
            child: _buildCompanyOverview(),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              10.verticalSpace,
              Row(
                children: [
                  Text(
                    LocaleKeys.reviews.tr().capital + ':',
                    style: TextStyleManager.s18w700,
                  )
                ],
              ),
            ]),
          ),
          PostsList.sliver(
            controller: _controller,
            getPostsListProviderParams: _postsProviderParams,
            getPosts: _getPostsOnCertainTarget,
            noPadding: true,
          ),
        ],
      ),
    );
  }
}
