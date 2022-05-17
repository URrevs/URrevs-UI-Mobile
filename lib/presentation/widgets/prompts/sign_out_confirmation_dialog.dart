import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// prompt that logs user from this device and sends a request to log out from
/// other devices

class SignOutConfirmationDialog extends StatefulWidget {
  const SignOutConfirmationDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<SignOutConfirmationDialog> createState() =>
      _SignOutConfirmationDialogState();
}

class _SignOutConfirmationDialogState extends State<SignOutConfirmationDialog> {
  bool logOutFromAlldevices = false;
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: LocaleKeys.sureToLogOut.tr(),
      hasTitle: true,
      content: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        value: logOutFromAlldevices,
        onChanged: (bool? value) {
          setState(() {
            logOutFromAlldevices = value!;
          });
        },
        title: Text(
          LocaleKeys.logOutFromAllDevices.tr(),
          style: TextStyleManager.s16w500.copyWith(color: ColorManager.black),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            LocaleKeys.cancel.tr(),
            style: TextStyleManager.s16w900.copyWith(
              color: ColorManager.black,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            LocaleKeys.logOut.tr(),
            style: TextStyleManager.s16w900.copyWith(
              color: ColorManager.red,
            ),
          ),
          onPressed: () async {
            // removing our back end token
            GetIt.I<Dio>().options.headers[HttpHeaders.authorizationHeader] =
                null;
            await Future.wait([
              GoogleSignIn().signOut(),
              FacebookAuth.instance.logOut(),
              FirebaseAuth.instance.signOut(),
            ]);
            Navigator.of(context).pushNamedAndRemoveUntil(
              AuthenticationScreen.routeName,
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}
