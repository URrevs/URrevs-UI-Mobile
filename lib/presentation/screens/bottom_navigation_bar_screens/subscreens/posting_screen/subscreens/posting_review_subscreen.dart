import 'package:flutter/material.dart';

class PostingReviewSubscreen extends StatefulWidget {
  const PostingReviewSubscreen({Key? key}) : super(key: key);

  @override
  State<PostingReviewSubscreen> createState() => _PostingReviewSubscreenState();
}

class _PostingReviewSubscreenState extends State<PostingReviewSubscreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('review posting'),
    );
  }
}
