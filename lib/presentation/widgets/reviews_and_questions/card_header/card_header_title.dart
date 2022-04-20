import 'package:flutter/material.dart';

/// Build the line containing the author's name and the product name.
class CardHeaderTitle extends StatelessWidget {
  const CardHeaderTitle({
    Key? key,
    required this.authorName,
    required this.productName,
  }) : super(key: key);

  /// Name of review author.
  final String authorName;

  /// Name of product on which the review was posted.
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              authorName,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        Icon(Icons.arrow_right),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              productName,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
      ],
    );
  }
}