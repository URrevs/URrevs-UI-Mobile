import 'package:flutter/material.dart';

class FullscreenProductReviewScreen extends StatefulWidget {
  const FullscreenProductReviewScreen({Key? key}) : super(key: key);

  static const String routeName = 'FullscreenProductReviewScreen';

  @override
  State<FullscreenProductReviewScreen> createState() =>
      _FullscreenProductReviewScreenState();
}

class _FullscreenProductReviewScreenState
    extends State<FullscreenProductReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
