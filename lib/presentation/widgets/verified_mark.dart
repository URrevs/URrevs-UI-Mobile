import 'package:easy_localization/easy_localization.dart' hide TextDirection;
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
  }) : super(key: key);

  final double verificationRatio;
  final bool isPhone;

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
    return Tooltip(
      message: tooltip,
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.h),
        child: Icon(
          Icons.check_circle,
          color: ColorManager.blue,
          size: 16.sp,
        ),
      ),
    );
  }
}
