import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answers_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comments_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class FullscreenPostScreenArgs {
  final CardType cardType;
  final bool focusOnTextField;
  FullscreenPostScreenArgs({
    required this.cardType,
    this.focusOnTextField = false,
  });
}

class FullscreenPostScreen extends StatefulWidget {
  const FullscreenPostScreen(
    this.screenArgs, {
    Key? key,
  }) : super(key: key);

  final FullscreenPostScreenArgs screenArgs;

  static const String routeName = 'FullscreenProductReviewScreen';

  @override
  State<FullscreenPostScreen> createState() => _FullscreenPostScreenState();
}

class _FullscreenPostScreenState extends State<FullscreenPostScreen> {
  FocusNode focusNode = FocusNode();

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
    if (widget.screenArgs.focusOnTextField) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarWithActions(context: context),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                children: [
                  expandedCard,
                  20.verticalSpace,
                  interactionsList,
                ],
              ),
            ),
            Container(
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
            )
          ],
        ),
      ),
    );
  }
}
