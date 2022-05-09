import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';

class ProductProfileQASubscreen extends StatefulWidget {
  const ProductProfileQASubscreen({Key? key}) : super(key: key);

  @override
  State<ProductProfileQASubscreen> createState() =>
      _ProductProfileQASubscreenState();
}

class _ProductProfileQASubscreenState extends State<ProductProfileQASubscreen> {
  Widget get listItem => (<Widget>[
        QuestionCard.dummyInstance(context).copyWith(
          onPressingAnswer: () {
            Navigator.of(context).pushNamed(
              FullscreenPostScreen.routeName,
              arguments: FullscreenPostScreenArgs(
                postId: '',
                cardType: CardType.productQuestion,
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
