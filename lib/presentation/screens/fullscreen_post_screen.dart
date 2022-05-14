import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/data/requests/base_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/reviews_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/quesiton.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';

import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/notifiers/authentication_notifier.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/question_states/get_post_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/add_comment_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/add_review_reply_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_comments_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_list_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/vertical_list_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answer_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answers_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comment_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comments_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/reply.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets.dart';
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
  late final TargetType _targetType = TargetType.phone;
  late final PostType _postType = widget.screenArgs.postType;

  late final GetPostProviderParams _postProviderParams =
      GetPostProviderParams(postId: _postId, postType: _postType);

  late final GetCommentsProviderParams _commentsProviderParams =
      GetCommentsProviderParams(
    postId: _postId,
    postType: widget.screenArgs.postType,
  );
  late final _addCommentProviderParams =
      AddCommentProviderParams(postId: _postId, postType: _postType);

  final List<Comment> _comments = [];

  String? _idOfCommentRepliedTo;

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
    ref.read(getPostProvider(_postProviderParams).notifier).getPost();
  }

  void _getComments() {
    ref
        .read(getCommentsProvider(_commentsProviderParams).notifier)
        .getComments();
  }

  void _addCommentOrReply() {
    AddInteractionRequest request =
        AddInteractionRequest(content: _controller.text);
    if (_idOfCommentRepliedTo != null) {
      ref
          .read(addCommentProvider(_addCommentProviderParams).notifier)
          .addReply(_idOfCommentRepliedTo!, request);
      return;
    }
    ref
        .read(addCommentProvider(_addCommentProviderParams).notifier)
        .addComment(request);
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
    Future.delayed(Duration.zero, () {
      _getPost();
      _getComments();
    });
    if (widget.screenArgs.focusOnTextField) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: getPostProvider(_postProviderParams),
      context: context,
    );
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
    final postState = ref.watch(getPostProvider(_postProviderParams));
    final commentsState =
        ref.watch(getCommentsProvider(_commentsProviderParams));
    Widget? widget = fullScreenErrorWidgetOrNull(
      [
        StateAndRetry(state: postState, onRetry: _getPost),
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
              _buildComments(),
            ],
          ),
        ),
        _buildTextFieldSection()
      ],
    );
  }

  Widget _buildComments() {
    final state = ref.watch(getCommentsProvider(_commentsProviderParams));
    bool roundsEnded = state is GetCommentsLoadedState && state.roundsEnded;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCommentsTrees(),
        _buildCommentsListLoadingOrError(),
        if (_comments.isNotEmpty && !roundsEnded) _buildMoreCommentsButton(),
      ],
    );
  }

  // Widget _buildPostedComment() {
  //   final state = ref.watch(addCommentProvider(_addCommentProviderParams));
  //   final user =
  //       (ref.watch(authenticationProvider) as AuthenticationLoadedState).user;
  //   if (state is LoadingState) {
  //     return CommentTree(
  //       userId: user.id,
  //       commentId: null,
  //       imageUrl: user.picture,
  //       authorName: user.name,
  //       commentText: _controller.text,
  //       likeCount: 0,
  //       datePosted: DateTime.now(), // not shown
  //       replies: [], // not shown
  //       liked: false, // not shown
  //       onPressingReply: () {},
  //       parentPostType: widget.screenArgs.postType,
  //     );
  //   } else {
  //     return SizedBox();
  //   }
  // }

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
    final state = ref.watch(getCommentsProvider(_commentsProviderParams));
    if (state is LoadedState && _comments.isEmpty) return EmptyListWidget();
    return CommentsList(
      comments: _comments,
      parentPostType: widget.screenArgs.postType,
      onPressingReplyList: List.generate(_comments.length, (i) {
        return () {
          _idOfCommentRepliedTo = _comments[i].id;
          focusNode.requestFocus();
        };
      }),
    );
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
    final state = ref.watch(getPostProvider(_postProviderParams));
    Widget? loadingOrErrorwidget = loadingOrErrorWidgetOrNull(
      state: state,
      loadingWidget: PhoneReviewLoading(),
    );
    if (loadingOrErrorwidget != null) return loadingOrErrorwidget;
    switch (widget.screenArgs.postType) {
      case PostType.phoneReview:
        return _buildPhoneReview();
      case PostType.companyReview:
        return _buildCompanyReview();
      case PostType.phoneQuestion:
      case PostType.companyQuestion:
        return _buildQuestion();
      default:
        return SizedBox();
    }
  }

  Widget _buildPhoneReview() {
    final state = ref.watch(getPostProvider(_postProviderParams));
    PhoneReview phoneReview = (state as GetPostLoadedState).post as PhoneReview;
    return ProductReviewCard.fromPhoneReview(
      phoneReview: phoneReview,
      fullscreen: true,
      onPressingComment: () {
        focusNode.requestFocus();
        _idOfCommentRepliedTo = null;
      },
    );
  }

  Widget _buildQuestion() {
    final state = ref.watch(getPostProvider(_postProviderParams));
    Question question = (state as GetPostLoadedState).post as Question;
    PostType postType = _targetType == TargetType.phone
        ? PostType.phoneQuestion
        : PostType.companyQuestion;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionCard.fromQuestion(
          question,
          cardHeaderTitleType: _targetType,
          cardType: widget.screenArgs.cardType,
          fullscreen: true,
          onPressingAnswer: () {},
        ),
        if (question.acceptedAns != null)
          AnswerTree.fromAnswer(
            question.acceptedAns!,
            parentPostType: postType,
            accepted: true,
            isQuestionAuthor: false,
            inQuestionCard: false,
            onTappingAnswerInCard: null,
            onPressingReply: () {},
          ),
      ],
    );
  }

  Widget _buildCompanyReview() {
    final state = ref.watch(getPostProvider(_postProviderParams));
    CompanyReview companyReview =
        (state as GetPostLoadedState).post as CompanyReview;
    return CompanyReviewCard.fromCompanyReview(
      companyReview: companyReview,
      fullscreen: true,
      onPressingComment: () {
        focusNode.requestFocus();
        _idOfCommentRepliedTo = null;
      },
    );
  }

  Widget _buildTextFieldSection() {
    ref.addErrorListener(
      provider: addCommentProvider(_addCommentProviderParams),
      context: context,
      margin: EdgeInsets.fromLTRB(15.h, 5.h, 15.h, 10.h + 60.h),
    );
    ref.listen(addCommentProvider(_addCommentProviderParams), (previous, next) {
      if (next is AddCommentLoadedState) {
        if (_idOfCommentRepliedTo == null) {
          Comment lastPostedComment = _postedCommentModel(
            commentId: next.commentId,
            createdAt: DateTime.now(),
            content: _controller.text,
          );
          ref
              .read(getCommentsProvider(_commentsProviderParams).notifier)
              .addCommentToState(lastPostedComment);
        } else {
          final User user =
              (ref.watch(authenticationProvider) as AuthenticationLoadedState)
                  .user;
          ReplyModel lastPostedReply = ReplyModel(
            id: next.commentId,
            userId: user.id,
            userName: user.name,
            photo: user.picture,
            createdAt: DateTime.now(),
            content: _controller.text,
            likes: 0,
            liked: false,
          );
          ref
              .read(getCommentsProvider(_commentsProviderParams).notifier)
              .addReplyToCommentInState(
                  _idOfCommentRepliedTo!, lastPostedReply);
        }
        _controller.text = '';
      }
    });
    final addCommentState =
        ref.watch(addCommentProvider(_addCommentProviderParams));
    late bool loading = addCommentState is LoadingState;
    ;

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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.send,
                size: 26.sp,
              ),
              onPressed: loading ? null : _addCommentOrReply,
              color: ColorManager.blue,
            ),
          ),
        ),
      ),
    );
  }
}
