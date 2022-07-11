import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/all_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/home_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/leaderboard_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/menu_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/posting_screen/posting_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/comparison_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_current_user_image_url_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_user_profile_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/give_points_to_user_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/bottom_navigation_bar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/confirmation_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class BottomNavBarIndeces {
  static const int allProductsSubscreen = 0;
  static const int postingSubscreen = 1;
  static const int homeSubscreen = 2;
  static const int leaderboardSubscreen = 3;
  static const int menuSubscreen = 4;
}

class BottomNavigationBarContainerScreenArgs {
  int screenIndex;
  PendingDynamicLinkData? initialLink;
  BottomNavigationBarContainerScreenArgs({
    required this.screenIndex,
    required this.initialLink,
  });
}

class BottomNavigationBarContainerScreen extends ConsumerStatefulWidget {
  const BottomNavigationBarContainerScreen(this.screenArgs, {Key? key})
      : super(key: key);

  final BottomNavigationBarContainerScreenArgs screenArgs;

  static const String routeName = 'BottomNavigationBarContainerScreen';

  @override
  ConsumerState<BottomNavigationBarContainerScreen> createState() =>
      _BottomNavigationBarContainerScreenState();
}

class _BottomNavigationBarContainerScreenState
    extends ConsumerState<BottomNavigationBarContainerScreen> {
  late final StreamSubscription<PendingDynamicLinkData> _dynLinkSubs;

  late int _currentIndex = widget.screenArgs.screenIndex;

  String? _refCode;

  bool get showTabBar => _currentIndex == 1;

  Widget get currentPage {
    switch (_currentIndex) {
      case BottomNavBarIndeces.allProductsSubscreen:
        return AllProductsSubscreen();
      case BottomNavBarIndeces.postingSubscreen:
        return PostingSubscreen(refCode: _refCode);
      case BottomNavBarIndeces.homeSubscreen:
        return HomeSubscreen();
      case BottomNavBarIndeces.leaderboardSubscreen:
        return LeaderboardSubscreen();
      case BottomNavBarIndeces.menuSubscreen:
        return MenuSubscreen();
      default:
        return HomeSubscreen();
    }
  }

  PreferredSize? get appBar {
    return AppBars.appBarWithURrevsLogo(
      context: context,
      showTabBar: showTabBar,
      imageUrl: ref.currentUser!.picture,
    );
  }

  void _setCurrentIndex(int i) async {
    if (_currentIndex == BottomNavBarIndeces.homeSubscreen) {
      FirebaseAnalytics.instance.logEvent(name: 'home_screen_view');
    }
    if (_currentIndex == BottomNavBarIndeces.postingSubscreen) {
      bool? leave = await showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          title: LocaleKeys.doYouReallyWantToLeave.tr(),
          content: LocaleKeys.thisWillCauseTheDataYouEnteredToBeErased.tr(),
        ),
      );
      if (leave != true) return;
    }
    setState(() => _currentIndex = i);
  }

  void _handlePostLink(PendingDynamicLinkData dynamicLinkData) {
    Map<String, String> queries = dynamicLinkData.link.queryParameters;
    for (final key in ['linkType', 'postId', 'userId', 'postType']) {
      if (!queries.containsKey(key)) return;
    }
    LinkType? linkType = LinkTypeExtension.parse(queries['linkType'] as String);
    if (linkType == null || linkType != LinkType.post) return;

    final postId = queries['postId'] as String;
    final userId = queries['userId'] as String;
    PostType? postType = PostTypeExtension.parse(queries['postType'] as String);

    if (postType == null) return;

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamed(
        FullscreenPostScreen.routeName,
        arguments: FullscreenPostScreenArgs(
          cardType: postType.cardType,
          postId: postId,
          postUserId: userId,
          postType: postType,
        ),
      );
    });
  }

  void _handleRefCodeLink(PendingDynamicLinkData dynamicLinkData) {
    Map<String, String> queries = dynamicLinkData.link.queryParameters;
    for (final key in ['linkType', 'refCode']) {
      if (!queries.containsKey(key)) return;
    }
    LinkType? linkType = LinkTypeExtension.parse(queries['linkType'] as String);
    if (linkType == null || linkType != LinkType.refCode) return;

    String refCode = queries['refCode'] as String;
    if (refCode == ref.currentRefCode!) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocaleKeys.youCannotUseYourInvitationCode.tr())),
      );
      return;
    }

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      while (!ModalRoute.of(context)!.isCurrent) {
        Navigator.of(context).pop();
      }
      setState(() {
        _refCode = refCode;
        _currentIndex = BottomNavBarIndeces.postingSubscreen;
      });
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        _refCode = null; // Clearing refCode after passing it.
      });
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logEvent(name: 'home_screen_view');
    Future.delayed(
      Duration.zero,
      ref.read(givePointsToUserProvider.notifier).givePointsToUser,
    );

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      final initialLink = widget.screenArgs.initialLink;
      if (initialLink != null) {
        _handlePostLink(initialLink);
        _handleRefCodeLink(initialLink);
      }
    });

    _dynLinkSubs = FirebaseDynamicLinks.instance.onLink
        .listen((PendingDynamicLinkData dynamicLinkData) {
      _handlePostLink(dynamicLinkData);
      _handleRefCodeLink(dynamicLinkData);
    })
      ..onError((error) {
        print('dynamic link error');
      });
  }

  @override
  void dispose() {
    _dynLinkSubs.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(givePointsToUserProvider, (previous, next) {
      if (next is GivePointsToUserLoadedState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              LocaleKeys.youHaveGotPointsForLoggingInThroughTheMobileApp.tr(),
            ),
          ),
        );
      }
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar,
        body: SafeArea(child: currentPage),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: _setCurrentIndex,
        ),
      ),
    );
  }
}
