import 'package:flutter/material.dart';

class ProductProfileScreen extends StatefulWidget {
  const ProductProfileScreen({Key? key}) : super(key: key);

  static const String routeName = 'ProductProfileScreen';

  @override
  State<ProductProfileScreen> createState() => _ProductProfileScreenState();
}

class _ProductProfileScreenState extends State<ProductProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
