import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/bottom_navigation_bar_container_screen.dart';

import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/urrevs_logo.dart';

class SplashScreenArgs {
  PendingDynamicLinkData? initialLink;
  SplashScreenArgs({
    this.initialLink,
  });
}

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key, required this.screenArgs}) : super(key: key);

  static const String routeName = 'SplashScreen';

  final SplashScreenArgs screenArgs;

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late PendingDynamicLinkData? _initialLink = widget.screenArgs.initialLink;

  late final StreamSubscription<PendingDynamicLinkData> _dynLinkSubs;
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

    // login user automatically
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      if (FirebaseAuth.instance.currentUser != null) {
        ref.read(authenticationProvider.notifier).loginToOurBackend();
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AuthenticationScreen.routeName,
          (route) => false,
          arguments: AuthenticationScreenArgs(
            initialLink: _initialLink,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _dynLinkSubs.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authenticationProvider, (previous, next) {
      if (next is AuthenticationErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.failure.message),
          ),
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          AuthenticationScreen.routeName,
          (route) => false,
          arguments: AuthenticationScreenArgs(
            initialLink: _initialLink,
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
      body: Padding(
        padding: AppEdgeInsets.screenPadding,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: URrevsLogo(),
              ),
            ),
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
