import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class FullscreenErrorWidget extends StatelessWidget {
  const FullscreenErrorWidget({
    this.retryLastRequest = true,
    required this.onRetry,
    Key? key,
  }) : super(key: key);

  final bool retryLastRequest;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.somethingWentWrong.tr()),
          if (retryLastRequest)
            ElevatedButton(
              onPressed: onRetry,
              child: Text(LocaleKeys.retry.tr()),
            ),
        ],
      ),
    );
  }
}
