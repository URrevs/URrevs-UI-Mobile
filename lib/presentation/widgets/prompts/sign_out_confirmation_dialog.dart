import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/logout_from_all_devices_state.dart';
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
  bool _logOutFromAlldevices = false;
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: ColorManager.transparent,
          body: Stack(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  // color should be provided for the container to capture
                  // taps
                  color: ColorManager.transparent,
                ),
              ),
              CustomAlertDialog(
                title: LocaleKeys.sureToLogOut.tr(),
                hasTitle: true,
                content: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _logOutFromAlldevices,
                  onChanged: (bool? value) {
                    setState(() => _logOutFromAlldevices = value!);
                  },
                  title: Text(
                    LocaleKeys.logOutFromAllDevices.tr(),
                    style: TextStyleManager.s16w500
                        .copyWith(color: ColorManager.black),
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
                  Consumer(builder: (context, ref, _) {
                    return _buildLogoutButton(context, ref);
                  }),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref) {
    ref.listen(logoutFromAllDevicesProvider, (previous, next) async {
      if (next is LogoutFromAllDevicesLoadedState) {
        // removing our back end token
        GetIt.I<Dio>().options.headers[HttpHeaders.authorizationHeader] = null;
        await Future.wait([
          GoogleSignIn().signOut(),
          FacebookAuth.instance.logOut(),
          FirebaseAuth.instance.signOut(),
        ]);
        Navigator.of(context).pushNamedAndRemoveUntil(
          AuthenticationScreen.routeName,
          (route) => false,
          arguments: AuthenticationScreenArgs(initialLink: null),
        );
        return;
      }
    });
    ref.addErrorListener(
      provider: logoutFromAllDevicesProvider,
      context: context,
    );
    final state = ref.watch(logoutFromAllDevicesProvider);
    bool loading = state is LogoutFromAllDevicesLoadingState;
    return SizedBox(
      height: 40.h,
      width: 160.w,
      child: loading
          ? Center(
              child: SizedBox(
                height: 20.sp,
                width: 20.sp,
                child: CircularProgressIndicator(
                  color: ColorManager.red,
                ),
              ),
            )
          : TextButton(
              child: Text(
                LocaleKeys.logOut.tr(),
                style: TextStyleManager.s16w900.copyWith(
                  color: ColorManager.red,
                ),
              ),
              onPressed: () async {
                if (!_logOutFromAlldevices) {
                  // removing our back end token
                  GetIt.I<Dio>()
                      .options
                      .headers[HttpHeaders.authorizationHeader] = null;
                  await Future.wait([
                    GoogleSignIn().signOut(),
                    FacebookAuth.instance.logOut(),
                    FirebaseAuth.instance.signOut(),
                  ]);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AuthenticationScreen.routeName,
                    (route) => false,
                    arguments: AuthenticationScreenArgs(initialLink: null),
                  );
                  return;
                }
                ref
                    .read(logoutFromAllDevicesProvider.notifier)
                    .logoutFromAllDevices();
              },
            ),
    );
  }
}
