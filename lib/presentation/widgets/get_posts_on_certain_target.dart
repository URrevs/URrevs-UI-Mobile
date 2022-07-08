import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/posts_list.dart';

class PostsListOnCertainTarget extends ConsumerStatefulWidget {
  const PostsListOnCertainTarget({
    Key? key,
    required this.targetId,
    required this.targetType,
    required this.postContentType,
  }) : super(key: key);

  final String targetId;
  final TargetType targetType;
  final PostContentType postContentType;

  @override
  ConsumerState<PostsListOnCertainTarget> createState() =>
      _PostsListOnCertainTargetState();
}

class _PostsListOnCertainTargetState
    extends ConsumerState<PostsListOnCertainTarget> {
  late final PagingController<int, Post> _controller =
      PagingController(firstPageKey: 0)
        ..addPageRequestListener((_) {
          Future.delayed(Duration.zero, _getPostsOnCertainTarget);
        });

  late final String _targetId = widget.targetId;
  late final TargetType _targetType = widget.targetType;
  late final PostContentType _postContentType = widget.postContentType;

  late final GetPostsListProviderParams _providerParams =
      GetPostsListProviderParams();

  Future<void> _getPostsOnCertainTarget() async {
    _controller.retryLastFailedRequest();
    return ref
        .read(getPostsListProvider(_providerParams).notifier)
        .getPostsList(
          postsListType: PostsListType.target,
          targetType: _targetType,
          postContentType: _postContentType,
          targetId: _targetId,
          userId: null,
        );
  }

  @override
  Widget build(BuildContext context) {
    Widget? errWidget = fullScreenErrorWidgetOrNull([
      StateAndRetry(
        state: ref.watch(getPostsListProvider(_providerParams)),
        onRetry: _getPostsOnCertainTarget,
        controller: _controller,
      ),
    ]);
    if (errWidget != null) return errWidget;
    return PostsList(
      controller: _controller,
      getPostsListProviderParams: _providerParams,
      getPosts: _getPostsOnCertainTarget,
      isSliver: false,
    );
  }
}
