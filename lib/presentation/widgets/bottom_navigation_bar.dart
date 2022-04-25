import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  /// The index of the current selected tab.
  final int currentIndex;

  /// The callback called when the user selects a tab.
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
        boxShadow: [
          BoxShadow(color: ColorManager.black, spreadRadius: 0, blurRadius: 1),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorManager.white,
          elevation: 30,
          iconSize: 30.sp,
          selectedItemColor: ColorManager.blue,
          selectedLabelStyle: TextStyleManager.s14w700,
          unselectedItemColor: ColorManager.buttonGrey,
          unselectedLabelStyle: TextStyleManager.s14w400,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(IconsManager.products),
              label: LocaleKeys.categoryNavBarItem.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconsManager.add),
              label: LocaleKeys.AddNavBarItem.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconsManager.home),
              label: LocaleKeys.homeNavBarItem.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconsManager.leaderboard),
              label: LocaleKeys.leaderboardNavBarItem.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(IconsManager.menu),
              label: LocaleKeys.menuNavBarItem.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
