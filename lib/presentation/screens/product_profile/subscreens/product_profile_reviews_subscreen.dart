import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/review_card_list_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';

import '../../../widgets/empty_list_widget.dart';

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
  late final PagingController<int, PhoneReview> _controller =
      PagingController(firstPageKey: 0)
        ..addPageRequestListener((_) {
          Future.delayed(Duration.zero, _getReviewsOnCertainPhone);
        });

  late final String _phoneId = widget.phoneId;

  late final GetReviewsOnCertainPhoneProviderParams _providerParams =
      GetReviewsOnCertainPhoneProviderParams(phoneId: _phoneId);

  void _getReviewsOnCertainPhone() {
    _controller.retryLastFailedRequest();
    ref
        .read(getReviewsOnCertainPhoneProvider(_providerParams).notifier)
        .getReviewsOnCertainPhone();
  }

  Widget _buildPhonesList() {
    ref.addErrorListener(
      provider: getReviewsOnCertainPhoneProvider(_providerParams),
      context: context,
      controller: _controller,
    );
    ref.addInfiniteScrollingListener(
      getReviewsOnCertainPhoneProvider(_providerParams),
      _controller,
    );
    Widget? errWidget = fullScreenErrorWidgetOrNull([
      StateAndRetry(
        state: ref.watch(getReviewsOnCertainPhoneProvider(_providerParams)),
        onRetry: _getReviewsOnCertainPhone,
        controller: _controller,
      ),
    ]);
    if (errWidget != null) return errWidget;
    return PagedListView(
      padding: AppEdgeInsets.screenPadding,
      pagingController: _controller,
      builderDelegate: PagedChildBuilderDelegate<PhoneReview>(
        itemBuilder: (context, phoneReview, index) {
          return ProductReviewCard.fromPhoneReview(
            phoneReview: phoneReview,
            fullscreen: false,
            onPressingComment: () {
              Navigator.of(context).pushNamed(
                FullscreenPostScreen.routeName,
                arguments: FullscreenPostScreenArgs(
                  postUserId: phoneReview.userId,
                  postType: PostType.phoneReview,
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
          return verticalListErrorWidget(
            state: ref.watch(getReviewsOnCertainPhoneProvider(_providerParams)),
            onRetry: _getReviewsOnCertainPhone,
            controller: _controller,
          );
        },
        firstPageProgressIndicatorBuilder: (context) =>
            ReviewCardsListLoading(),
        newPageProgressIndicatorBuilder: (context) => ReviewCardsListLoading(),
        noItemsFoundIndicatorBuilder: (context) => EmptyListWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPhonesList();
  }
}
