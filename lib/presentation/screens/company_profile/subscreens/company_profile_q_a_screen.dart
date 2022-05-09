import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';

class CompanyProfileQASubscreen extends StatefulWidget {
  const CompanyProfileQASubscreen({Key? key}) : super(key: key);

  @override
  State<CompanyProfileQASubscreen> createState() =>
      _CompanyProfileQASubscreenState();
}

class _CompanyProfileQASubscreenState extends State<CompanyProfileQASubscreen> {
  Widget get listItem => (<Widget>[
        QuestionCard.dummyInstance(context).copyWith(
          onPressingAnswer: () {
            Navigator.of(context).pushNamed(
              FullscreenPostScreen.routeName,
              arguments: FullscreenPostScreenArgs(
                postId: '',
                cardType: CardType.companyQuestion,
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
