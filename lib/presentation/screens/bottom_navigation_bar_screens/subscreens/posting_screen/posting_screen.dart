import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/posting_screen/subscreens/posting_question_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/posting_screen/subscreens/posting_review_screen.dart';

class PostingSubscreen extends StatefulWidget {
  const PostingSubscreen({Key? key}) : super(key: key);

  @override
  State<PostingSubscreen> createState() => _PostingSubscreenState();
}

class _PostingSubscreenState extends State<PostingSubscreen> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        PostingReviewSubscreen(),
        PostingQuestionSubscreen(),
      ],
    );
  }
}
