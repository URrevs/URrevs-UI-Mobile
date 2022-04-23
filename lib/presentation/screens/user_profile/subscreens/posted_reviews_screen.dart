import 'package:flutter/material.dart';

class PostedReviewsScreen extends StatefulWidget {
  const PostedReviewsScreen({Key? key}) : super(key: key);

  static const String routeName = 'PostedReviewsScreen';

  @override
  State<PostedReviewsScreen> createState() => _PostedReviewsScreenState();
}

class _PostedReviewsScreenState extends State<PostedReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
