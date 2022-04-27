import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_product_review_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/question_card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';

class HomeSubscreen extends StatefulWidget {
  const HomeSubscreen({Key? key}) : super(key: key);

  @override
  State<HomeSubscreen> createState() => _HomeSubscreenState();
}

class _HomeSubscreenState extends State<HomeSubscreen> {
  Widget get listItem => (<Widget>[
        ProductReviewCard.dummyInstance().copyWith(
          onPressingComment: () {
            Navigator.of(context).pushNamed(
              FullscreenProductReviewScreen.routeName,
              arguments: CardType.productReview,
            );
          },
        ),
        CompanyReviewCard.dummyInstance().copyWith(
          onPressingComment: () {
            Navigator.of(context).pushNamed(
              FullscreenProductReviewScreen.routeName,
              arguments: CardType.companyReview,
            );
          },
        ),
        QuestionCard.dummyInstance(context).copyWith(
          cardType: CardType.productQuestion,
          onPressingAnswer: () {
            Navigator.of(context).pushNamed(
              FullscreenProductReviewScreen.routeName,
              arguments: CardType.productQuestion,
            );
          },
        ),
        QuestionCard.dummyInstance(context).copyWith(
          cardType: CardType.companyQuestion,
          onPressingAnswer: () {
            Navigator.of(context).pushNamed(
              FullscreenProductReviewScreen.routeName,
              arguments: CardType.companyQuestion,
            );
          },
        ),
      ]..shuffle())
          .first;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      itemBuilder: (context, index) => listItem,
      itemCount: 10,
    );
  }
}
