import 'package:flutter/material.dart';

class FullscreenCompanyReviewScreen extends StatefulWidget {
  const FullscreenCompanyReviewScreen({Key? key}) : super(key: key);

  static const String routeName = 'FullscreenCompanyReviewScreen';

  @override
  State<FullscreenCompanyReviewScreen> createState() =>
      _FullscreenCompanyReviewScreenState();
}

class _FullscreenCompanyReviewScreenState
    extends State<FullscreenCompanyReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('company review fullscreen'),
      ),
    );
  }
}
