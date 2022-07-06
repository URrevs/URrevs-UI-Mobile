import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/post_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';

import '../../domain/failure.dart';
import '../../domain/models/phone_review.dart';
import '../../domain/models/post.dart';
import '../../domain/models/question.dart';
import '../resources/enums.dart';
import '../screens/fullscreen_post_screen.dart';
import '../state_management/providers_parameters.dart';
import '../utils/states_util.dart';
import 'empty_widgets/empty_list_widget.dart';
import 'error_widgets/vertical_list_error_widget.dart';
import 'loading_widgets/post_list_loading.dart';

class PostsList extends ConsumerStatefulWidget {
  const PostsList({
    Key? key,
    required this.controller,
    required this.getPostsListProviderParams,
    required this.getPosts,
    required this.isSliver,
    this.noPadding = false,
  }) : super(key: key);

  const PostsList.sliver({
    Key? key,
    required this.controller,
    required this.getPostsListProviderParams,
    required this.getPosts,
    this.noPadding = false,
  })  : isSliver = true,
        super(key: key);

  const PostsList.box({
    Key? key,
    required this.controller,
    required this.getPostsListProviderParams,
    required this.getPosts,
    this.noPadding = false,
  })  : isSliver = false,
        super(key: key);

  final GetPostsListProviderParams getPostsListProviderParams;
  final PagingController<int, Post> controller;
  final VoidCallback getPosts;
  final bool isSliver;
  final bool noPadding;

  @override
  ConsumerState<PostsList> createState() => _PostsListState();
}

class _PostsListState extends ConsumerState<PostsList> {
  Widget _buildPost(Post post) {
    if (post is Question) {
      Question question = post;
      CardType cardType = question.type == TargetType.phone
          ? CardType.productQuestion
          : CardType.companyQuestion;
      PostType postType = question.type == TargetType.phone
          ? PostType.phoneQuestion
          : PostType.companyQuestion;
      return QuestionCard.fromQuestion(
        question,
        cardHeaderTitleType: question.type,
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

  PagedChildBuilderDelegate<Post> _pagedChildBuilderDelegate() {
    return PagedChildBuilderDelegate<Post>(
      itemBuilder: (context, post, index) => _buildPost(post),
      firstPageErrorIndicatorBuilder: (context) => SizedBox(),
      newPageErrorIndicatorBuilder: (context) {
        final state =
            ref.watch(getPostsListProvider(widget.getPostsListProviderParams));
        if (state is ErrorState) {
          return VerticalListErrorWidget(
            onRetry: widget.getPosts,
            retryLastRequest: (state as ErrorState).failure is RetryFailure,
          );
        } else {
          return SizedBox();
        }
      },
      firstPageProgressIndicatorBuilder: (context) => PostListLoading(),
      newPageProgressIndicatorBuilder: (context) => PostListLoading(),
      noItemsFoundIndicatorBuilder: (context) => EmptyListWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: getPostsListProvider(widget.getPostsListProviderParams),
      context: context,
      controller: widget.controller,
    );
    ref.addInfiniteScrollingListener(
      getPostsListProvider(widget.getPostsListProviderParams),
      widget.controller,
    );
    final padding = widget.noPadding
        ? EdgeInsets.all(0)
        : EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h);
    if (widget.isSliver) {
      return SliverPadding(
        padding: padding,
        sliver: PagedSliverList(
          pagingController: widget.controller,
          builderDelegate: _pagedChildBuilderDelegate(),
        ),
      );
    }
    return Padding(
      padding: padding,
      child: PagedListView(
        pagingController: widget.controller,
        builderDelegate: _pagedChildBuilderDelegate(),
      ),
    );
  }
}
