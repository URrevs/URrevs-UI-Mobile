import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/question_card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';

class HomeSubscreen extends ConsumerStatefulWidget {
  const HomeSubscreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeSubscreen> createState() => _HomeSubscreenState();
}

class _HomeSubscreenState extends ConsumerState<HomeSubscreen> {
  Widget get listItem => (<Widget>[
        ProductReviewCard.dummyInstance().copyWith(
          onPressingComment: () {
            Navigator.of(context).pushNamed(
              FullscreenPostScreen.routeName,
              arguments: FullscreenPostScreenArgs(
                cardType: CardType.productReview,
                postId: '',
                focusOnTextField: true,
              ),
            );
          },
        ),
        CompanyReviewCard.dummyInstance().copyWith(
          onPressingComment: () {
            Navigator.of(context).pushNamed(
              FullscreenPostScreen.routeName,
              arguments: FullscreenPostScreenArgs(
                cardType: CardType.companyReview,
                postId: '',
                focusOnTextField: true,
              ),
            );
          },
        ),
        QuestionCard.dummyInstance(context).copyWith(
          cardType: CardType.productQuestion,
          onPressingAnswer: () {
            Navigator.of(context).pushNamed(
              FullscreenPostScreen.routeName,
              arguments: FullscreenPostScreenArgs(
                cardType: CardType.productQuestion,
                postId: '',
                focusOnTextField: true,
              ),
            );
          },
        ),
        QuestionCard.dummyInstance(context).copyWith(
          cardType: CardType.companyQuestion,
          onPressingAnswer: () {
            Navigator.of(context).pushNamed(
              FullscreenPostScreen.routeName,
              arguments: FullscreenPostScreenArgs(
                cardType: CardType.companyQuestion,
                postId: '',
                focusOnTextField: true,
              ),
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
