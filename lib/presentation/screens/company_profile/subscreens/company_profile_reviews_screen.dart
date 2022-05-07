import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/rating_overview_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';

class CompanyProfileReviewsSubscreen extends StatefulWidget {
  const CompanyProfileReviewsSubscreen({Key? key}) : super(key: key);

  @override
  State<CompanyProfileReviewsSubscreen> createState() =>
      _CompanyProfileReviewsSubscreenState();
}

class _CompanyProfileReviewsSubscreenState
    extends State<CompanyProfileReviewsSubscreen> {
  Widget get listItem => (<Widget>[
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
        )
      ]..shuffle())
          .first;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              RatingOverviewCard(
                  productName: 'Nokia',
                  generalCompanyRating: 3.5,
                  viewsCounter: 600,
                  isProduct: false),
              listItem
            ],
          );
        } else {
          return listItem;
        }
      },
      itemCount: 10,
      padding: AppEdgeInsets.screenPadding,
    );
  }
}
