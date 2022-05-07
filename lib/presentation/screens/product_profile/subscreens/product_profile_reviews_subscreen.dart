import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/development_widgets.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';

class ProductProfileReviewsSubscreen extends StatefulWidget {
  const ProductProfileReviewsSubscreen({Key? key}) : super(key: key);

  @override
  State<ProductProfileReviewsSubscreen> createState() =>
      _ProductProfileReviewsSubscreenState();
}

class _ProductProfileReviewsSubscreenState
    extends State<ProductProfileReviewsSubscreen> {
  Widget get listItem => (<Widget>[
        ProductReviewCard.dummyInstance().copyWith(
          onPressingComment: () {
            Navigator.of(context).pushNamed(
              FullscreenPostScreen.routeName,
              arguments: FullscreenPostScreenArgs(
                cardType: CardType.productReview,
                reviewId: '',
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
          return listItem;
        },
        itemCount: 10,
        padding: AppEdgeInsets.screenPadding);
  }
}
