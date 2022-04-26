import 'package:flutter/material.dart';

class PostingQuestionSubscreen extends StatefulWidget {
  const PostingQuestionSubscreen({Key? key}) : super(key: key);

  @override
  State<PostingQuestionSubscreen> createState() =>
      _PostingQuestionSubscreenState();
}

class _PostingQuestionSubscreenState extends State<PostingQuestionSubscreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('review posting'),
    );
  }
}
