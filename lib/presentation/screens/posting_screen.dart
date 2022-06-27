import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/posting_screen/subscreens/posting_question_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/posting_screen/subscreens/posting_review_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class PostingScreenArgs {
  PostContentType postContentType;
  Phone? phone;
  Company? company;
  PostingScreenArgs({
    required this.postContentType,
    this.phone,
    this.company,
  }) : assert(!(postContentType == PostContentType.review && company != null));
}

class PostingScreen extends StatefulWidget {
  const PostingScreen({Key? key, required this.screenArgs}) : super(key: key);

  static const String routeName = 'PostingScreen';

  final PostingScreenArgs screenArgs;

  @override
  State<PostingScreen> createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  bool get isAddReview =>
      widget.screenArgs.postContentType == PostContentType.review;

  Widget get body => isAddReview
      ? PostingReviewSubscreen(refCode: null, phone: widget.screenArgs.phone)
      : PostingQuestionSubscreen(
          phone: widget.screenArgs.phone,
          company: widget.screenArgs.company,
        );

  String get appBarText =>
      isAddReview ? LocaleKeys.addReview.tr() : LocaleKeys.addQuestion.tr();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarWithTitle(context: context, title: appBarText),
      body: body,
    );
  }
}
