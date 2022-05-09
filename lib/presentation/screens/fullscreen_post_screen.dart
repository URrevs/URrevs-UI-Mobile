import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/data/requests/reviews_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';

import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/add_comment_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_comments_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_company_review_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_phone_review_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/vertical_list_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answers_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comment_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comments_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/comments_list_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/company_review_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/phone_review_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

import '../resources/text_button_style_manager.dart';

class FullscreenPostScreenArgs {
  final CardType cardType;
  final bool focusOnTextField;
  final String postId;
  final PostType postType;
  FullscreenPostScreenArgs({
    required this.cardType,
    required this.postId,
    this.postType = PostType.phoneReview,
    this.focusOnTextField = false,
  });

  static FullscreenPostScreenArgs get defaultArgs {
    return FullscreenPostScreenArgs(
      cardType: CardType.productReview,
      postType: PostType.phoneReview,
      postId: 'change_it',
    );
  }
}

class FullscreenPostScreen extends ConsumerStatefulWidget {
  const FullscreenPostScreen(
    this.screenArgs, {
    Key? key,
  }) : super(key: key);

  final FullscreenPostScreenArgs screenArgs;

  static const String routeName = 'FullscreenProductReviewScreen';

  @override
  ConsumerState<FullscreenPostScreen> createState() =>
      _FullscreenPostScreenState();
}

class _FullscreenPostScreenState extends ConsumerState<FullscreenPostScreen> {
  FocusNode focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  late final String _postId = widget.screenArgs.postId;
  late final GetCommentsProviderParams _commentsProviderParams =
      GetCommentsProviderParams(
    postId: _postId,
    postType: widget.screenArgs.postType,
  );

  final _addCommentProviderParams = AddCommentProviderParams();

  final List<Comment> _comments = [];

  Comment _postedCommentModel({
    required String commentId,
    required DateTime createdAt,
    required String content,
  }) {
    final User user =
        (ref.watch(authenticationProvider) as AuthenticationLoadedState).user;
    return Comment(
      id: commentId,
      userId: user.id,
      userName: user.name,
      photo: user.picture,
      createdAt: createdAt,
      content: content,
      likes: 0,
      liked: false,
      replies: [],
    );
  }

  void _getPost() {
    switch (widget.screenArgs.postType) {
      case PostType.phoneReview:
        return _getProductReview();
      case PostType.companyReview:
        return _getCompanyReview();
      // case CardType.productQuestion:
      // case CardType.companyQuestion:
      default:
        return;
    }
  }

  void _getProductReview() {
    ref
        .read(getPhoneReviewProvider.notifier)
        .getPhoneReview(widget.screenArgs.postId);
  }

  void _getCompanyReview() {
    ref
        .read(getCompanyReviewProvider.notifier)
        .getCompanyReview(widget.screenArgs.postId);
  }

  void _getComments() {
    ref
        .read(getCommentsProvider(_commentsProviderParams).notifier)
        .getComments();
  }

  void _addComment() {
    if (widget.screenArgs.postType == PostType.phoneReview) {
      AddCommentToPhoneReviewRequest request =
          AddCommentToPhoneReviewRequest(content: _controller.text);
      ref
          .read(addCommentProvider(_addCommentProviderParams).notifier)
          .addCommentToPhoneReview(widget.screenArgs.postId, request);
    }
  }

  String get _hintText {
    switch (widget.screenArgs.cardType) {
      case CardType.productQuestion:
      case CardType.companyQuestion:
        return LocaleKeys.writeAnAnswer.tr();
      default:
        return LocaleKeys.writeAComment.tr();
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.screenArgs.postId);
    _getPost();
    _getComments();
    if (widget.screenArgs.focusOnTextField) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(provider: getPhoneReviewProvider, context: context);
    ref.addErrorListener(provider: getCompanyReviewProvider, context: context);
    return Scaffold(
      appBar: AppBars.appBarWithActions(
        context: context,
        imageUrl: ref.watch(userImageUrlProvider),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final phoneReviewState = ref.watch(getPhoneReviewProvider);
    final companyReviewState = ref.watch(getCompanyReviewProvider);
    final commentsState =
        ref.watch(getCommentsProvider(_commentsProviderParams));
    Widget? widget = fullScreenErrorWidgetOrNull(
      [
        StateAndRetry(state: phoneReviewState, onRetry: _getPost),
        StateAndRetry(state: companyReviewState, onRetry: _getPost),
        if (_comments.isEmpty)
          StateAndRetry(state: commentsState, onRetry: _getComments),
      ],
    );
    if (widget != null) return widget;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            children: [
              _buildPost(),
              20.verticalSpace,
              _buildPostedComment(),
              _buildComments(),
            ],
          ),
        ),
        _buildTextFieldSection()
      ],
    );
  }

  Widget _buildComments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCommentsTrees(),
        _buildCommentsListLoadingOrError(),
        _buildMoreCommentsButton(),
      ],
    );
  }

  Widget _buildPostedComment() {
    final state = ref.watch(addCommentProvider(_addCommentProviderParams));
    final user =
        (ref.watch(authenticationProvider) as AuthenticationLoadedState).user;
    if (state is LoadingState) {
      return CommentTree(
        userId: user.id,
        commentId: null,
        imageUrl: user.picture,
        authorName: user.name,
        commentText: _controller.text,
        likeCount: 0,
        datePosted: DateTime.now(), // not shown
        replies: [], // not shown
        liked: false, // not shown
      );
    } else {
      return SizedBox();
    }
  }

  Widget _buildMoreCommentsButton() {
    final state = ref.watch(getCommentsProvider(_commentsProviderParams));
    if (state is LoadingState || state is ErrorState) {
      return SizedBox();
    }
    return Container(
      alignment:
          context.isArabic ? Alignment.centerRight : Alignment.centerLeft,
      child: TextButton(
        onPressed: _getComments,
        style: TextButtonStyleManager.showMoreAnswers,
        child: Text(
          LocaleKeys.moreComments.tr(),
          style: TextStyleManager.s16w800.copyWith(color: ColorManager.black),
        ),
      ),
    );
  }

  Widget _buildCommentsTrees() {
    // add new comments to state
    // also show snackbar at first round error
    ref.listen(getCommentsProvider(_commentsProviderParams), (previous, next) {
      if (next is GetCommentsLoadedState) {
        _comments.clear();
        _comments.addAll(next.infiniteScrollingItems);
      } else if (next is GetCommentsErrorState && _comments.isEmpty) {
        showSnackBarWithoutActionAtError(state: next, context: context);
      }
    });
    return CommentsList(comments: _comments);
  }

  // always return loading widget when in loading state
  // return vertical error widget at error state accompanied by presence of
  // comments in the state (next round error)
  Widget _buildCommentsListLoadingOrError() {
    final state = ref.watch(getCommentsProvider(_commentsProviderParams));
    if (state is ErrorState && _comments.isNotEmpty) {
      return VerticalListErrorWidget(
        onRetry: _getComments,
        retryLastRequest: (state as ErrorState).failure is RetryFailure,
      );
    } else if (state is LoadingState) {
      return CommentsListLoading();
    } else {
      return SizedBox();
    }
  }

  Widget _buildPost() {
    switch (widget.screenArgs.postType) {
      case PostType.phoneReview:
        return _buildPhoneReview();
      case PostType.companyReview:
        return _buildCompanyReview();
      // case CardType.productQuestion:
      // case CardType.companyQuestion:
      default:
        return SizedBox();
    }
  }

  Widget _buildPhoneReview() {
    final state = ref.watch(getPhoneReviewProvider);
    Widget? widget = loadingOrErrorWidgetOrNull(
      state: state,
      loadingWidget: PhoneReviewLoading(),
    );
    if (widget != null) return widget;
    PhoneReview phoneReview = (state as GetPhoneReviewLoadedState).review;
    return ProductReviewCard(
      reviewId: phoneReview.id,
      productId: phoneReview.targetId,
      userId: phoneReview.userId,
      postedDate: phoneReview.createdAt,
      usedSinceDate: phoneReview.ownedAt,
      views: phoneReview.views,
      authorName: phoneReview.userName,
      imageUrl: phoneReview.photo,
      productName: phoneReview.targetName,
      scores: phoneReview.scores,
      prosText: phoneReview.pros,
      consText: phoneReview.cons,
      likeCount: phoneReview.likes,
      commentCount: phoneReview.commentsCount,
      shareCount: phoneReview.shares,
      liked: phoneReview.liked,
      fullscreen: true,
      onPressingComment: () => focusNode.requestFocus(),
    );
  }

  Widget _buildCompanyReview() {
    final state = ref.watch(getCompanyReviewProvider);
    Widget? widget = loadingOrErrorWidgetOrNull(
      state: state,
      loadingWidget: CompanyReviewLoading(),
    );
    if (widget != null) return widget;
    CompanyReview companyReview = (state as GetCompanyReviewLoadedState).review;
    return CompanyReviewCard(
      reviewId: companyReview.id,
      userId: companyReview.userId,
      companyId: companyReview.targetId,
      postedDate: companyReview.createdAt,
      views: companyReview.views,
      authorName: companyReview.userName,
      imageUrl: companyReview.photo,
      companyName: companyReview.targetName,
      generalRating: companyReview.generalRating.toInt(),
      prosText: companyReview.pros,
      consText: companyReview.cons,
      likeCount: companyReview.likes,
      commentCount: companyReview.commentsCount,
      shareCount: companyReview.shares,
      liked: companyReview.liked,
      fullscreen: true,
      onPressingComment: () => focusNode.requestFocus(),
    );
  }

  Widget _buildTextFieldSection() {
    ref.listen(addCommentProvider(_addCommentProviderParams), (previous, next) {
      if (next is AddCommentLoadedState) {
        Comment lastPostedComment = _postedCommentModel(
          commentId: next.commentId,
          createdAt: DateTime.now(),
          content: _controller.text,
        );
        ref
            .read(getCommentsProvider(_commentsProviderParams).notifier)
            .addCommentToState(lastPostedComment);
        _controller.text = '';
      }
    });
    final state = ref.watch(addCommentProvider(_addCommentProviderParams));
    bool loading = state is LoadingState;
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: ColorManager.grey.withOpacity(0.2),
            spreadRadius: 1,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        child: TextField(
          controller: _controller,
          focusNode: focusNode,
          style: TextStyleManager.s16w300,
          enabled: !loading,
          decoration: InputDecoration(
            hintText: _hintText,
            filled: true,
            fillColor: ColorManager.textFieldGrey,
            focusColor: Colors.red,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.send,
                color: ColorManager.blue,
                size: 26.sp,
              ),
              onPressed: loading ? null : _addComment,
            ),
          ),
        ),
      ),
    );
  }
}
