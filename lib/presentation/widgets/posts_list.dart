import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';

import '../../domain/failure.dart';
import '../../domain/models/phone_review.dart';
import '../../domain/models/post.dart';
import '../../domain/models/quesiton.dart';
import '../resources/enums.dart';
import '../screens/fullscreen_post_screen.dart';
import '../state_management/providers_parameters.dart';
import '../utils/states_util.dart';
import 'empty_widgets/empty_list_widget.dart';
import 'error_widgets/vertical_list_error_widget.dart';
import 'loading_widgets/review_card_list_loading.dart';

class SliverPostsList extends ConsumerStatefulWidget {
  const SliverPostsList({
    Key? key,
    required this.targetType,
    required this.controller,
    required this.getUserPostsProviderParams,
    required this.getPosts,
  }) : super(key: key);

  final TargetType targetType;
  final GetPostsListProviderParams getUserPostsProviderParams;
  final PagingController<int, Post> controller;
  final VoidCallback getPosts;

  @override
  ConsumerState<SliverPostsList> createState() => _SliverPostsListState();
}

class _SliverPostsListState extends ConsumerState<SliverPostsList> {
  Widget _buildPost(Post post) {
    if (post is Question) {
      Question question = post;
      CardType cardType = widget.targetType == TargetType.phone
          ? CardType.productQuestion
          : CardType.companyQuestion;
      PostType postType = widget.targetType == TargetType.phone
          ? PostType.phoneQuestion
          : PostType.companyQuestion;
      return QuestionCard.fromQuestion(
        question,
        cardHeaderTitleType: widget.targetType,
        cardType: cardType,
        fullscreen: false,
        onPressingAnswer: () {
          Navigator.of(context).pushNamed(
            FullscreenPostScreen.routeName,
            arguments: FullscreenPostScreenArgs(
              postUserId: question.userId,
              postType: postType,
              cardType: cardType,
              postId: question.id,
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
              postUserId: phoneReview.userId,
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
            postUserId: companyReview.userId,
            postType: PostType.companyReview,
            cardType: CardType.companyReview,
            postId: companyReview.id,
            focusOnTextField: true,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: getPostsListProvider(widget.getUserPostsProviderParams),
      context: context,
      controller: widget.controller,
    );
    ref.addInfiniteScrollingListener(
      getPostsListProvider(widget.getUserPostsProviderParams),
      widget.controller,
    );
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      sliver: PagedSliverList(
        pagingController: widget.controller,
        builderDelegate: PagedChildBuilderDelegate<Post>(
          itemBuilder: (context, post, index) => _buildPost(post),
          firstPageErrorIndicatorBuilder: (context) => SizedBox(),
          newPageErrorIndicatorBuilder: (context) {
            final state = ref
                .watch(getPostsListProvider(widget.getUserPostsProviderParams));
            if (state is ErrorState) {
              return VerticalListErrorWidget(
                onRetry: widget.getPosts,
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
}
