import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/all_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/home_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/leaderboard_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/menu_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/posting_screen/posting_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/bottom_navigation_bar.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class BottomNavigationBarContainerScreen extends StatefulWidget {
  const BottomNavigationBarContainerScreen({Key? key}) : super(key: key);

  static const String routeName = 'BottomNavigationBarContainerScreen';

  @override
  State<BottomNavigationBarContainerScreen> createState() =>
      _BottomNavigationBarContainerScreenState();
}

class _BottomNavigationBarContainerScreenState
    extends State<BottomNavigationBarContainerScreen> {
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

  void _setCurrentIndex(int i) => setState(() => _currentIndex = i);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBars.appBarWithURrevsLogo(
          context: context,
          showTabBar: showTabBar,
        ),
        body: currentPage,
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: _setCurrentIndex,
        ),
      ),
    );
  }
}
