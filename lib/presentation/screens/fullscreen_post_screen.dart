import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/review.dart';

import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_phone_review_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answers_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comments_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/phone_review_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class FullscreenPostScreenArgs {
  final CardType cardType;
  final bool focusOnTextField;
  final String reviewId;
  FullscreenPostScreenArgs({
    required this.cardType,
    required this.reviewId,
    this.focusOnTextField = false,
  });

  static FullscreenPostScreenArgs get defaultArgs {
    return FullscreenPostScreenArgs(
      cardType: CardType.productReview,
      reviewId: '',
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

  void _getPost() {
    if (widget.screenArgs.cardType == CardType.productReview) {
      ref
          .read(getPhoneReviewProvider.notifier)
          .getPhoneReview(widget.screenArgs.reviewId);
    }
  }

  String get hintText {
    switch (widget.screenArgs.cardType) {
      case CardType.productQuestion:
      case CardType.companyQuestion:
        return LocaleKeys.writeAnAnswer.tr();
      default:
        return LocaleKeys.writeAComment.tr();
    }
  }

  Widget get expandedCard {
    switch (widget.screenArgs.cardType) {
      case CardType.productReview:
        return ProductReviewCard.dummyInstance().copyWith(
          fullscreen: true,
          onPressingComment: focusNode.requestFocus,
        );
      case CardType.companyReview:
        return CompanyReviewCard.dummyInstance().copyWith(
            fullscreen: true, onPressingComment: focusNode.requestFocus);
      case CardType.productQuestion:
      case CardType.companyQuestion:
        return QuestionCard.dummyInstance(context).copyWith(
          fullscreen: true,
          onPressingAnswer: focusNode.requestFocus,
        );
      default:
        return ProductReviewCard.dummyInstance(fullscreen: true);
    }
  }

  Widget get interactionsList {
    switch (widget.screenArgs.cardType) {
      case CardType.productReview:
      case CardType.companyReview:
        return CommentsList.dummyInstance;
      case CardType.productQuestion:
      case CardType.companyQuestion:
        return AnswersList.dummyInstance;
      default:
        return CommentsList.dummyInstance;
    }
  }

  @override
  void initState() {
    super.initState();
    _getPost();
    if (widget.screenArgs.focusOnTextField) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(provider: getPhoneReviewProvider, context: context);
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
    final state = ref.watch(getPhoneReviewProvider);
    Widget? widget = fullScreenErrorWidgetOrNull(
      [StateAndRetry(state: state, onRetry: _getPost)],
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
              interactionsList,
            ],
          ),
        ),
        _buildTextFieldSection()
      ],
    );
  }

  Widget _buildPost() {
    final state = ref.watch(getPhoneReviewProvider);
    Widget? widget = loadingOrErrorWidgetOrNull(
      state: state,
      loadingWidget: PhoneReviewLoading(),
    );
    if (widget != null) return widget;
    PhoneReview phoneReview = (state as GetPhoneReviewLoadedState).review;
    return ProductReviewCard(
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

  Widget _buildTextFieldSection() {
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
          focusNode: focusNode,
          style: TextStyleManager.s16w300,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: ColorManager.textFieldGrey,
            focusColor: Colors.red,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: BorderSide.none,
            ),
            suffixIcon: Icon(
              Icons.send,
              color: ColorManager.blue,
              size: 26.sp,
            ),
          ),
        ),
      ),
    );
  }
}
