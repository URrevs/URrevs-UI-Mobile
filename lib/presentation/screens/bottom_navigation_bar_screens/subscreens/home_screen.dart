import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/posts_list.dart';

class HomeSubscreen extends ConsumerStatefulWidget {
  const HomeSubscreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomeSubscreen> createState() => _HomeSubscreenState();
}

class _HomeSubscreenState extends ConsumerState<HomeSubscreen> {
  late final PagingController<int, Post> _controller =
      PagingController(firstPageKey: 0)
        ..addPageRequestListener((_) {
          Future.delayed(Duration.zero, _getPostsForHomeScreen);
        });

  late final GetPostsListProviderParams _providerParams =
      GetPostsListProviderParams();

  Future<void> _getPostsForHomeScreen() async {
    _controller.retryLastFailedRequest();
    return ref
        .read(getPostsListProvider(_providerParams).notifier)
        .getPostsList(
          postsListType: PostsListType.home,
          targetType: null,
          postContentType: null,
          targetId: null,
          userId: null,
        );
  }

  @override
  Widget build(BuildContext context) {
    Widget? errWidget = fullScreenErrorWidgetOrNull([
      StateAndRetry(
        state: ref.watch(getPostsListProvider(_providerParams)),
        onRetry: _getPostsForHomeScreen,
        controller: _controller,
      ),
    ]);
    if (errWidget != null) return errWidget;
    return PostsList(
      controller: _controller,
      getPostsListProviderParams: _providerParams,
      getPosts: _getPostsForHomeScreen,
      isSliver: false,
    );
  }
}
