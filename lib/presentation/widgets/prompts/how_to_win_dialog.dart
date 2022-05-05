
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class HowToWinDialog extends StatelessWidget {
  const HowToWinDialog({
    Key? key,
  }) : super(key: key);

  Future launchGooglePlay() async {
    /// this is the url of the app in the google play store
  String url = 'https://flutter.dev';
  final Uri _url = Uri.parse(url);
  if (await canLaunchUrl(_url)) {
    await launchUrl(_url);
  } else {
    throw 'Could not launch $url';
  }
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
                  ),
                 recognizer: TapGestureRecognizer()
                   ..onTap = () =>
                       launchGooglePlay(),
                 ),
                 TextSpan(text: ' '),
                 TextSpan(text: '\n\n'),
                TextSpan(text: LocaleKeys.howToWinPrompt2.tr()),
              ],
            ),
          )),
    );
  }
}
