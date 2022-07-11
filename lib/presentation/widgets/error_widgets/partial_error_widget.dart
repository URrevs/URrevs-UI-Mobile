import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class PartialErrorWidget extends StatelessWidget {
  const PartialErrorWidget({
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
            Text(LocaleKeys.somethingWentWrong.tr()),
            if (retryLastRequest)
              ElevatedButton(
                onPressed: onRetry,
                child: Text(LocaleKeys.retry.tr()),
              ),
          ],
        ),
      ),
    );
  }
}
