import 'package:flutter/material.dart';

class QuestionsAboutMyProductsScreen extends StatefulWidget {
  const QuestionsAboutMyProductsScreen({Key? key}) : super(key: key);

  static const String routeName = 'QuestionsAboutMyProductsScreen';

  @override
  State<QuestionsAboutMyProductsScreen> createState() =>
      _QuestionsAboutMyProductsScreenState();
}

class _QuestionsAboutMyProductsScreenState
    extends State<QuestionsAboutMyProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Container()),
    );
  }
}
