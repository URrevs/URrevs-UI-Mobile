import 'package:flutter/material.dart';

class VerticalListErrorWidget extends StatelessWidget {
  const VerticalListErrorWidget({
    this.retryLastRequest = true,
    required this.onRetry,
    Key? key,
  }) : super(key: key);
  final bool retryLastRequest;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Vertical list error widget'),
            if (retryLastRequest)
              ElevatedButton(
                onPressed: onRetry,
                child: Text('Retry'),
              ),
          ],
        ),
      ),
    );
  }
}
