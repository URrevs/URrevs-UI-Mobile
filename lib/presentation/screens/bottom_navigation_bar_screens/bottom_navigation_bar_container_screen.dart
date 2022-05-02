import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/all_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/home_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/leaderboard_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/menu_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/posting_screen/posting_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_user_profile_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/bottom_navigation_bar.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class BottomNavigationBarContainerScreen extends ConsumerStatefulWidget {
  const BottomNavigationBarContainerScreen({Key? key}) : super(key: key);

  static const String routeName = 'BottomNavigationBarContainerScreen';

  @override
  ConsumerState<BottomNavigationBarContainerScreen> createState() =>
      _BottomNavigationBarContainerScreenState();
}

class _BottomNavigationBarContainerScreenState
    extends ConsumerState<BottomNavigationBarContainerScreen> {
  int _currentIndex = 2;

  bool get showTabBar => _currentIndex == 1;

  Widget get currentPage {
    switch (_currentIndex) {
      case 0:
        return AllProductsSubscreen();
      case 1:
        return PostingSubscreen();
      case 2:
        return HomeSubscreen();
      case 3:
        return LeaderboardSubscreen();
      case 4:
        return MenuSubscreen();
      default:
        return HomeSubscreen();
    }
  }

  AppBar? get appBar {
    if (_currentIndex == 0) return null;
    return AppBars.appBarWithURrevsLogo(
      context: context,
      showTabBar: showTabBar,
      imageUrl: ref.watch(userImageUrlProvider),
    );
  }

  void _setCurrentIndex(int i) => setState(() => _currentIndex = i);

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      ref.read(getMyProfileProvider.notifier).getMyProfile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar,
        body: SafeArea(child: currentPage),
        persistentFooterButtons: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                UserProfileScreen.routeName,
                arguments:
                    UserProfileScreenArgs(userId: '626b29227fe7587a42e3e9f6'),
              );
            },
            child: Text('ANOTHER USER PROFILE'),
          )
        ],
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: _setCurrentIndex,
        ),
      ),
    );
  }
}
