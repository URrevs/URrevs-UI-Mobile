import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answers_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comments_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';

class FullscreenProductReviewScreen extends StatefulWidget {
  const FullscreenProductReviewScreen({
    Key? key,
    required this.cardType,
  }) : super(key: key);

  final CardType cardType;

  static const String routeName = 'FullscreenProductReviewScreen';

  @override
  State<FullscreenProductReviewScreen> createState() =>
      _FullscreenProductReviewScreenState();
}

class _FullscreenProductReviewScreenState
    extends State<FullscreenProductReviewScreen> {
  FocusNode focusNode = FocusNode();

  Widget get expandedCard {
    switch (widget.cardType) {
      case CardType.productReview:
        return ProductReviewCard.dummyInstance(fullscreen: true);
      case CardType.companyReview:
        return CompanyReviewCard.dummyInstance(fullscreen: true);
      case CardType.productQuestion:
      case CardType.companyQuestion:
        return QuestionCard.dummyInstance(context, fullscreen: true);
      default:
        return ProductReviewCard.dummyInstance(fullscreen: true);
    }
  }

  Widget get interactionsList {
    switch (widget.cardType) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarWithActions(context: context),
      resizeToAvoidBottomInset: true,
      body: Column(
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
            color: ColorManager.white,
            child: TextField(
              focusNode: focusNode,
            ),
          )
        ],
      ),
    );
  }
}
