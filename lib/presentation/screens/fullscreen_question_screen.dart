import 'package:flutter/material.dart';

class FullscreenQuestionScreen extends StatefulWidget {
  const FullscreenQuestionScreen({Key? key}) : super(key: key);

  static const String routeName = 'FullscreenQuestionScreen';

  @override
  State<FullscreenQuestionScreen> createState() =>
      _FullscreenQuestionScreenState();
}

class _FullscreenQuestionScreenState extends State<FullscreenQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
