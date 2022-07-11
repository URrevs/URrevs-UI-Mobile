import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class VerifiedMark extends StatelessWidget {
  const VerifiedMark({
    Key? key,
    required this.verificationRatio,
    required this.isPhone,
    this.size,
  }) : super(key: key);

  final double verificationRatio;
  final bool isPhone;
  final double? size;

  String get tooltip {
    if (isPhone) {
      if (verificationStatus == VerificationStatus.iphone) {
        return LocaleKeys
            .thisPhoneHasBeenAddedToOwnedProductsThroughAnApplePhone
            .tr();
      } else {
        return '${LocaleKeys.thisPhoneIsVerifiedBy.tr()} ${verificationRatio.truncate()}%';
      }
    }
    if (verificationStatus == VerificationStatus.iphone) {
      return LocaleKeys.thisReviewIsFromAnApplePhone.tr();
    } else {
      return '${LocaleKeys.thisReviewIsVerifiedBy.tr()} ${verificationRatio.truncate()}%';
    }
  }

  VerificationStatus get verificationStatus {
    if (verificationRatio == 0) {
      return VerificationStatus.unverified;
    } else if (verificationRatio == -1) {
      return VerificationStatus.iphone;
    } else {
      return VerificationStatus.verified;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressDown: (_) {
        FirebaseAnalytics.instance.logEvent(
          name: 'holding_verified_mark',
          parameters: {
            'tooltip_text': tooltip,
            'mark_in_owned_products_screen': isPhone,
          },
        );
      },
      child: Tooltip(
        message: tooltip,
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: Icon(
            Icons.check_circle,
            color: ColorManager.blue,
            size: size ?? 16.sp,
          ),
        ),
      ),
    );
  }
}
