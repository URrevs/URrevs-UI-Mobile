import 'package:flutter/material.dart';

class PostedQuestionsScreen extends StatefulWidget {
  const PostedQuestionsScreen({Key? key}) : super(key: key);

  static const String routeName = 'PostedQuestionsScreen';

  @override
  State<PostedQuestionsScreen> createState() => _PostedQuestionsScreenState();
}

class _PostedQuestionsScreenState extends State<PostedQuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
