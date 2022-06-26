import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/posts_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

import '../../../../../../domain/models/post.dart';
import '../../../../../state_management/providers_parameters.dart';

class QuestionsAboutMyProductsScreen extends ConsumerStatefulWidget {
  const QuestionsAboutMyProductsScreen({Key? key}) : super(key: key);

  static const String routeName = 'QuestionsAboutMyProductsScreen';

  @override
  ConsumerState<QuestionsAboutMyProductsScreen> createState() =>
      _QuestionsAboutMyProductsScreenState();
}

class _QuestionsAboutMyProductsScreenState
    extends ConsumerState<QuestionsAboutMyProductsScreen> {
  late final PagingController<int, Post> _controller =
      PagingController(firstPageKey: 0)
        ..addPageRequestListener((_) {
          Future.delayed(Duration.zero, () {
            _getQuestionsAboutMyOwnedPhones();
          });
        });

  late final GetPostsListProviderParams _providerParams =
      GetPostsListProviderParams();

  void _getQuestionsAboutMyOwnedPhones() {
    _controller.retryLastFailedRequest();
    ref.read(getPostsListProvider(_providerParams).notifier).getPostsList(
          postsListType: PostsListType.questionsOnMyOwnedPhones,
          targetType: null,
          postContentType: null,
          targetId: null,
          userId: null,
        );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      appBar: AppBars.appBarWithTitle(
        context: context,
        title: LocaleKeys.questionsOnMyProducts.tr(),
        elevation: 1,
      ),
      onPressingFab: () {},
      hideFab: true,
      fabLabel: LocaleKeys.addQuestion.tr(),
      fabIcon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    Widget? errWidget = fullScreenErrorWidgetOrNull([
      StateAndRetry(
        state: ref.watch(getPostsListProvider(_providerParams)),
        onRetry: _getQuestionsAboutMyOwnedPhones,
        controller: _controller,
      ),
    ]);
    if (errWidget != null) return errWidget;
    return CustomScrollView(
      slivers: [
        PostsList(
          controller: _controller,
          getPostsListProviderParams: _providerParams,
          getPosts: _getQuestionsAboutMyOwnedPhones,
          isSliver: true,
        ),
      ],
    );
  }
}
