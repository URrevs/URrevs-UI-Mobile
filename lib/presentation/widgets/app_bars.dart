import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/app/exceptions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/search_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/company_horizontal_list_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AppBars {
  static List<Widget> actions({
    required BuildContext context,
    required String? imageUrl,
  }) {
    return <Widget>[
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(SearchScreen.routeName);
        },
        child: CircleAvatar(
          radius: 18.r,
          backgroundColor: ColorManager.appBarIconBackground,
          child: Icon(
            IconsManager.search,
            color: ColorManager.black,
            size: 30.sp,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 5.w),
        child: Avatar(
          imageUrl: imageUrl,
          radius: 18.r,
          onTap: () {
            Navigator.of(context).pushNamed(UserProfileScreen.routeName);
          },
        ),
      ),
      // ElevatedButton(
      //   onPressed: () => context.setLocale(LanguageType.ar.locale),
      //   child: Text('ar'),
      // ),
      // ElevatedButton(
      //   onPressed: () => context.setLocale(LanguageType.en.locale),
      //   child: Text('en'),
      // ),
    ];
  }

  static PreferredSize appBarWithURrevsLogo({
    required BuildContext context,
    required bool showTabBar,
    required String? imageUrl,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        45.h,
      ),
      child: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Image.asset(
            ImageAssets.appBarLogo,
            // width: 94,
            // height: 30,
            filterQuality: FilterQuality.high,
          ),
        ),
        leadingWidth: 105.w,
        backgroundColor: ColorManager.white,
        actions: AppBars.actions(context: context, imageUrl: imageUrl),
        bottom: showTabBar
            ? TabBar(
                tabs: [
                  Tab(text: LocaleKeys.tabBarReview.tr()),
                  Tab(text: LocaleKeys.tabBarQuestion.tr()),
                ],
              )
            : null,
      ),
    );
  }

  static PreferredSize appBarWithActions({
    required BuildContext context,
    required String imageUrl,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        45.h,
      ),
      child: AppBar(
        // leading: Icon(Icons.arrow_back_rounded, size: 30.sp,),
        backgroundColor: ColorManager.white,
        actions: AppBars.actions(context: context, imageUrl: imageUrl),
        iconTheme: IconThemeData(
          color: ColorManager.black,
        ),
      ),
    );
  }

  static PreferredSize appBarWithTitle({
    required BuildContext context,
    required String title,
  }) {
    return PreferredSize(
        preferredSize: Size.fromHeight(
          45.h,
        ),
        child: AppBar(title: Text(title, style: TextStyleManager.s20w700,)));
  }

  static AppBar appBarOfProductProfile({
    required BuildContext context,
    required TabController controller,
    required String text,
    required String imageUrl,
  }) {
    return AppBar(
      title: Row(
        children: AppBars.actions(
          context: context,
          imageUrl: imageUrl,
        ),
      ),
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
    required String imageUrl,
  }) {
    return AppBar(
      title: Row(
        children: AppBars.actions(
          context: context,
          imageUrl: imageUrl,
        ),
      ),
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

  static appBarWithCompaniesList() {
    return SliverAppBar(
      title: SizedBox(
        height: 30.h,
        width: 95.w,
        child: Placeholder(),
      ),
      actions: [
        ElevatedButton(onPressed: () {}, child: Text('PROFILE')),
        ElevatedButton(onPressed: () {}, child: Text('SEARCH')),
      ],
      pinned: true,
      forceElevated: true,
      snap: true,
      floating: true,
      toolbarHeight: 45.h,
      collapsedHeight: 45.h,
      expandedHeight: 45.h + 95.h + 10.h,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(top: 45.h),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            CompanyHorizontalListTile(companyItems: companyItems),
          ],
        ),
      ),
    );
  }
}
