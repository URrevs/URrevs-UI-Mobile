import 'package:flutter/material.dart';

class FullscreenErrorWidget extends StatelessWidget {
  const FullscreenErrorWidget({
    required this.onRetry,
    Key? key,
  }) : super(key: key);

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Partial error widget'),
          ElevatedButton(
            onPressed: onRetry,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
