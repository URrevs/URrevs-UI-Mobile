import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/all_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/home_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/leaderboard_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/menu_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/posting_screen/posting_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/comparison_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_current_user_image_url_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_user_profile_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/give_points_to_user_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/bottom_navigation_bar.dart';
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
  BottomNavigationBarContainerScreenArgs({
    required this.screenIndex,
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
  late int _currentIndex = widget.screenArgs.screenIndex;

  bool get showTabBar => _currentIndex == 1;

  Widget get currentPage {
    switch (_currentIndex) {
      case BottomNavBarIndeces.allProductsSubscreen:
        return AllProductsSubscreen();
      case BottomNavBarIndeces.postingSubscreen:
        return PostingSubscreen();
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
    final state =
        ref.watch(authenticationProvider) as AuthenticationLoadedState;
    return AppBars.appBarWithURrevsLogo(
      context: context,
      showTabBar: showTabBar,
      imageUrl: state.user.picture,
    );
  }

  void _setCurrentIndex(int i) => setState(() => _currentIndex = i);

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      ref.read(givePointsToUserProvider.notifier).givePointsToUser,
    );
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
