import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/posting_screen/subscreens/posting_question_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/posting_screen/subscreens/posting_review_subscreen.dart';

class PostingSubscreen extends StatefulWidget {
  const PostingSubscreen({
    Key? key,
    required this.refCode,
  }) : super(key: key);

  final String? refCode;

  @override
  State<PostingSubscreen> createState() => _PostingSubscreenState();
}

class _PostingSubscreenState extends State<PostingSubscreen> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        PostingReviewSubscreen(refCode: widget.refCode),
        PostingQuestionSubscreen(),
      ],
    );
  }
}
