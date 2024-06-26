import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/bottom_navigation_bar_container_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/auth_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/urrevs_logo.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AuthenticationScreenArgs {
  PendingDynamicLinkData? initialLink;
  AuthenticationScreenArgs({
    required this.initialLink,
  });
}

class AuthenticationScreen extends ConsumerStatefulWidget {
  const AuthenticationScreen({
    Key? key,
    required this.screenArgs,
  }) : super(key: key);

  final AuthenticationScreenArgs screenArgs;

  static const String routeName = 'AuthenticationScreen';

  @override
  ConsumerState<AuthenticationScreen> createState() =>
      _AuthenticationScreenState();
}

class _AuthenticationScreenState extends ConsumerState<AuthenticationScreen> {
  late PendingDynamicLinkData? _initialLink = widget.screenArgs.initialLink;

  late final StreamSubscription<PendingDynamicLinkData> _dynLinkSubs;

  Align _buildLanguageButton() {
    Locale targetLocale =
        context.isArabic ? LanguageType.en.locale : LanguageType.ar.locale;
    Alignment alignment =
        context.isArabic ? Alignment.topLeft : Alignment.topRight;
    return Align(
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: ElevatedButton(
          onPressed: () => context.setLocale(targetLocale),
          style: ElevatedButton.styleFrom(
            shadowColor: ColorManager.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 12.h,
            ),
          ),
          child: Text(
            LocaleKeys.toggleLanguageButtonText.tr(),
            style: TextStyleManager.s14w700.copyWith(
              fontFamily: FontConstants.tajawal,
              color: ColorManager.elevatedButtonTextColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthenticationButtons() {
    return Column(
      children: [
        AuthButton(
          text: LocaleKeys.googleAuth.tr(),
          imagePath: SvgAssets.googleLogo,
          color: ColorManager.grey,
          onPressed:
              ref.read(authenticationProvider.notifier).authenticateWithGoogle,
        ),
        35.verticalSpace,
        AuthButton(
          text: LocaleKeys.facebookAuth.tr(),
          imagePath: SvgAssets.facebookLogo,
          color: ColorManager.blue,
          onPressed: ref
              .read(authenticationProvider.notifier)
              .authenticateWithFacebook,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    // should subscibe to the stream in initState only !!
    _dynLinkSubs = FirebaseDynamicLinks.instance.onLink
        .listen((PendingDynamicLinkData dynamicLinkData) {
      _initialLink = dynamicLinkData;
    })
      ..onError((error) {
        print('dynamic link error');
      });
  }

  @override
  void dispose() {
    super.dispose();
    _dynLinkSubs.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthenticationState>(authenticationProvider, (previous, next) {
      if (next is AuthenticationLoadingState) {
        context.loaderOverlay.show();
      } else {
        if (context.loaderOverlay.visible) {
          context.loaderOverlay.hide();
        }
      }
      if (next is AuthenticationErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.failure.message),
          ),
        );
      }
      if (next is AuthenticationLoadedState) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          BottomNavigationBarContainerScreen.routeName,
          (route) => false,
          arguments: BottomNavigationBarContainerScreenArgs(
            screenIndex: BottomNavBarIndeces.homeSubscreen,
            initialLink: _initialLink,
          ),
        );
      }
    });
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: LoaderOverlay(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLanguageButton(),
              80.verticalSpace,
              URrevsLogo(),
              80.verticalSpace,
              _buildAuthenticationButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
