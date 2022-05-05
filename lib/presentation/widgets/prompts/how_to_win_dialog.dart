
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class HowToWinDialog extends StatelessWidget {
  const HowToWinDialog({
    Key? key,
  }) : super(key: key);

  Future launchGooglePlay(String url) async {
  url = 'https://flutter.dev';
   print('object');
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  //   throw 'Could not launch $url';
  // }
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        LocaleKeys.howToWinPromptTitle.tr(),
        style: TextStyleManager.s16w700.copyWith(
          color: ColorManager.black,
          fontFamily: FontConstants.tajawal,
        ),
      ),
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppRadius.interactionBodyRadius),
      ),
      insetPadding: EdgeInsets.all(10.sp),
      content: SizedBox(
          width: 270.w,
          height: 480.h,
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              style: TextStyleManager.s16w500.copyWith(
                color: ColorManager.black,
                fontFamily: FontConstants.tajawal,
              ),
              children: [
                TextSpan(text: LocaleKeys.howToWinPrompt.tr()),
                TextSpan(
                  text: LocaleKeys.ourMobileApp.tr(),
                  style: TextStyleManager.s16w700.copyWith(
                    color: ColorManager.black,
                    fontFamily: FontConstants.tajawal,
                    decoration: TextDecoration.underline,
                  ),
                 recognizer: TapGestureRecognizer()
                   ..onTap = () =>
                       launchGooglePlay('https://play.google.com/store/apps/details?id=com.urrevs.urrevs'),
                 ),
                TextSpan(text: LocaleKeys.howToWinPrompt2.tr()),
              ],
            ),
          )),
    );
  }
}
