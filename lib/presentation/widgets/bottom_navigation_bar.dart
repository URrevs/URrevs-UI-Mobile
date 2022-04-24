import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
        boxShadow: [
          BoxShadow(
              color: ColorManager.black, spreadRadius: 0, blurRadius: 1),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
        child: BottomNavigationBar(
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
              icon: Icon(Icons.category_outlined),
              label: LocaleKeys.categoryNavBarItem.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: LocaleKeys.AddNavBarItem.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: LocaleKeys.homeNavBarItem.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.stars_rounded),
              label: LocaleKeys.leaderboardNavBarItem.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
              ),
              label: LocaleKeys.menuNavBarItem.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
