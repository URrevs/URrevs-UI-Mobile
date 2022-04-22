import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/answer_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/answers_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/comment_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/comments_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/comments_and_answers/reply.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/card_body_see_more_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/review_card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/specs_comparison_table.dart';

class DevelopmentScreen extends StatefulWidget {
  const DevelopmentScreen({Key? key}) : super(key: key);

  @override
  State<DevelopmentScreen> createState() => _DevelopmentScreenState();
}

class _DevelopmentScreenState extends State<DevelopmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => context.setLocale(LanguageType.ar.locale),
            child: Text('ar'),
          ),
          ElevatedButton(
            onPressed: () => context.setLocale(LanguageType.en.locale),
            child: Text('en'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     print("scale width: ${ScreenUtil().scaleWidth}");
          //     print("scale height: ${ScreenUtil().scaleHeight}");
          //     print("screen width: ${ScreenUtil().screenWidth}");
          //     print("ui size: ${ScreenUtil().uiSize}");
          //   },
          //   child: Text('screen util'),
          // ),
        ],
      ),
      body: ListView(
        children: [
          QuestionCard.dummyInstance,
        ],
      ),
    );
  }
}
