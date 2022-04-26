import 'package:flutter/material.dart';

class ProductProfileSpecsSubscreen extends StatefulWidget {
  const ProductProfileSpecsSubscreen({Key? key}) : super(key: key);

  @override
  State<ProductProfileSpecsSubscreen> createState() =>
      _ProductProfileSpecsSubscreenState();
}

class _ProductProfileSpecsSubscreenState
    extends State<ProductProfileSpecsSubscreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(child: Text('specs')),
      ],
    );
  }
}
