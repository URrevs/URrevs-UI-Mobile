import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/screens/search_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AppBars {
  static List<Widget> actions(BuildContext context) => <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(UserProfileScreen.routeName);
          },
          child: Text('profile'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(SearchScreen.routeName);
          },
          child: Text('search'),
        ),
      ];

  static AppBar appBarWithURrevsLogo({
    required BuildContext context,
    required bool showTabBar,
  }) {
    return AppBar(
      actions: AppBars.actions(context),
      bottom: showTabBar
          ? TabBar(
              tabs: [
                Tab(text: LocaleKeys.tabBarReview.tr()),
                Tab(text: LocaleKeys.tabBarQuestion.tr()),
              ],
            )
          : null,
    );
  }

  static AppBar appBarWithActions({required BuildContext context}) {
    return AppBar(
      actions: AppBars.actions(context),
    );
  }

  static AppBar appBarWithTitle({
    required BuildContext context,
    required String title,
  }) {
    return AppBar(title: Text(title));
  }

  static AppBar appBarOfProductProfile({
    required BuildContext context,
    required TabController controller,
    required String text,
  }) {
    return AppBar(
      title: Row(children: AppBars.actions(context)),
      actions: [Text(text)],
      bottom: TabBar(
        controller: controller,
        tabs: [
          Tab(text: LocaleKeys.tabBarReviews.tr()),
          Tab(text: LocaleKeys.tabBarSpecs.tr()),
          Tab(text: LocaleKeys.tabBarQuestionsAndAnswers.tr()),
        ],
      ),
    );
  }

  static AppBar appBarOfCompnayProfile({
    required BuildContext context,
    required TabController controller,
    required String text,
  }) {
    return AppBar(
      title: Row(children: AppBars.actions(context)),
      actions: [Text(text)],
      bottom: TabBar(
        controller: controller,
        tabs: [
          Tab(text: LocaleKeys.tabBarReviews.tr()),
          Tab(text: LocaleKeys.tabBarQuestionsAndAnswers.tr()),
        ],
      ),
    );
  }

  static SliverAppBar appBarWithFilters({
    required ValueChanged<ReviewsFilter> setFilter,
  }) {
    return SliverAppBar(
      pinned: true,
      forceElevated: true,
      snap: true,
      floating: true,
      stretch: true,
      toolbarHeight: 45.h,
      collapsedHeight: 45.h,
      expandedHeight: 90.h,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(top: 45.h),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () => setFilter(ReviewsFilter.phones),
              child: Text('الهواتف'),
            ),
            ElevatedButton(
              onPressed: () => setFilter(ReviewsFilter.companies),
              child: Text('الشركات'),
            ),
          ],
        ),
      ),
    );
  }
}
