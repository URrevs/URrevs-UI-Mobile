import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        ProductReviewCard.dummyInstance(),
        CompanyReviewCard.dummyInstance(),
        QuestionCard.dummyInstance(context),
      ]..shuffle())
          .first;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      itemBuilder: (context, index) => listItem,
      itemCount: 5,
    );
  }
}
