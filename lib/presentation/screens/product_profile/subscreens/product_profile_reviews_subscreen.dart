import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/posts_list.dart';


class ProductProfileReviewsSubscreen extends ConsumerStatefulWidget {
  const ProductProfileReviewsSubscreen({Key? key, required this.phoneId})
      : super(key: key);

  final String phoneId;

  @override
  ConsumerState<ProductProfileReviewsSubscreen> createState() =>
      _ProductProfileReviewsSubscreenState();
}

class _ProductProfileReviewsSubscreenState
    extends ConsumerState<ProductProfileReviewsSubscreen> {
  late final PagingController<int, Post> _controller =
      PagingController(firstPageKey: 0)
        ..addPageRequestListener((_) {
          Future.delayed(Duration.zero, _getReviewsOnCertainPhone);
        });

  late final String _phoneId = widget.phoneId;

  late final GetPostsListProviderParams _providerParams =
      GetPostsListProviderParams();

  void _getReviewsOnCertainPhone() {
    _controller.retryLastFailedRequest();
    ref.read(getPostsListProvider(_providerParams).notifier).getPostsList(
          postsListType: PostsListType.target,
          targetType: TargetType.phone,
          postContentType: PostContentType.review,
          targetId: _phoneId,
          userId: null,
        );
  }

  Widget _buildPhonesList() {
    Widget? errWidget = fullScreenErrorWidgetOrNull([
      StateAndRetry(
        state: ref.watch(getPostsListProvider(_providerParams)),
        onRetry: _getReviewsOnCertainPhone,
        controller: _controller,
      ),
    ]);
    if (errWidget != null) return errWidget;
    return PostsList.box(
      targetType: TargetType.phone,
      controller: _controller,
      getPostsListProviderParams: _providerParams,
      getPosts: _getReviewsOnCertainPhone,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPhonesList();
  }
}
