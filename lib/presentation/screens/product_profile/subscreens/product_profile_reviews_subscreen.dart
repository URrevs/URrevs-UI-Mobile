import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/development_widgets.dart';

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
    return ListView(
      children: [
        Center(child: Text('Reviews')),
      ],
    );
  }
}
