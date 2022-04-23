import 'package:flutter/material.dart';

class OwnedProductsScreen extends StatefulWidget {
  const OwnedProductsScreen({Key? key}) : super(key: key);

  static const String routeName = 'OwnedProductsScreen';

  @override
  State<OwnedProductsScreen> createState() => _OwnedProductsScreenState();
}

class _OwnedProductsScreenState extends State<OwnedProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
