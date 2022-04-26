import 'package:flutter/material.dart';

class ProductProfileReviewsSubscreen extends StatefulWidget {
  const ProductProfileReviewsSubscreen({Key? key}) : super(key: key);

  @override
  State<ProductProfileReviewsSubscreen> createState() =>
      _ProductProfileReviewsSubscreenState();
}

class _ProductProfileReviewsSubscreenState
    extends State<ProductProfileReviewsSubscreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Reviews'));
  }
}
