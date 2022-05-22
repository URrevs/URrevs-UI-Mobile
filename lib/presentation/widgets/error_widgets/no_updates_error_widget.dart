import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class NoUpdatesErrorWidget extends StatelessWidget {
  const NoUpdatesErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleKeys.noUpdateOperationsYet.tr()),
        ],
      ),
    );
  }
}
