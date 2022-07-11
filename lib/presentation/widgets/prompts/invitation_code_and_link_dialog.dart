import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// a prompt that copies text into user's clipboard
/// it contains a button that enables the user to share a link in different apps
class InvitationCodeDialog extends StatelessWidget {
  const InvitationCodeDialog({
    Key? key,
    required this.invitationCode,
  }) : super(key: key);

  /// the controller that holds the invitation code, you should set the value of the invitation code through invitationPromptCtl.text = 'your invitation code'.
  final String invitationCode;

  void _shareInvitationLink() async {
    Uri androidLink = Uri.https(
      StringsManager.webDomain,
      '/add-review',
      <String, String>{
        'linkType': LinkType.refCode.name,
        'refCode': invitationCode,
      },
    );

    Uri webLink = Uri.https(
      StringsManager.webDomain,
      '/add-review',
      <String, String>{'refCode': invitationCode},
    );

    final dynamicLinkParams = DynamicLinkParameters(
      link: androidLink,
      uriPrefix: StringsManager.uriPrefix,
      androidParameters: AndroidParameters(
        packageName: StringsManager.packageName,
        fallbackUrl: webLink,
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    Share.shareWithResult(dynamicLink.shortUrl.toString());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController invitationPromptCtl = TextEditingController();
    invitationPromptCtl.text = invitationCode;
    return ScaffoldMessenger(
      child: Builder(builder: (context) {
        return Stack(
          children: [
            IgnorePointer(
              child: Scaffold(
                backgroundColor: ColorManager.transparent,
              ),
            ),
            CustomAlertDialog(
              title: LocaleKeys.yourInvitationCode.tr() + ':',
              hasTitle: true,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.invitationCodePrompt.tr(),
                    style: TextStyleManager.s16w400,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Padding(
                        padding: context.isArabic
                            ? EdgeInsets.only(right: 80.w)
                            : EdgeInsets.only(left: 80.w),
                        child: SizedBox(
                          height: 60.h,
                          width: 120.w,
                          child: TextField(
                            controller: invitationPromptCtl,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            style: TextStyleManager.s22w500.copyWith(
                              color: ColorManager.black,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 5.w),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.backgroundGrey),
                                  borderRadius: BorderRadius.circular(5.r)),
                              filled: true,
                              fillColor:
                                  ColorManager.dialogCloseIconBackgroundGrey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      IconButton(
                        icon: Icon(
                          IconsManager.copy,
                          size: 30.sp,
                          color: ColorManager.black,
                        ),
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: invitationPromptCtl.text));
                          // show snackbar with text copied to clipboard
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                LocaleKeys.invitationCodeCopied.tr(),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 15.h),
                  // Grad button contains share invitation code and share icon
                  GradButton(
                    text: Text(
                      LocaleKeys.shareInvitationLink.tr(),
                      style: TextStyleManager.s18w700,
                    ),
                    icon: Icon(
                      IconsManager.share,
                      size: 23.sp,
                      color: ColorManager.elevatedButtonTextColor,
                    ),
                    width: 325.w,
                    reverseIcon: false,
                    onPressed: _shareInvitationLink,
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
