import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/search_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AppBars {
  static List<Widget> actions({
    required BuildContext context,
    required String? imageUrl,
    required bool isReversed,
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
        padding: isReversed
            ? EdgeInsets.only(
                top: 5.h,
                bottom: 5.h,
                right: !context.isArabic ? 15.w : 0,
                left: !context.isArabic ? 0 : 15.w)
            : EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
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
      preferredSize: Size.fromHeight(showTabBar ? 45.h + 45.h : 45.h),
      child: AppBar(
        elevation: 3,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Image.asset(
            ImageAssets.appBarLogo,
            //  width: 94,
            //  height: 30,
            filterQuality: FilterQuality.high,
          ),
        ),
        leadingWidth: 125.w,
        backgroundColor: ColorManager.white,
        actions: AppBars.actions(
            context: context, imageUrl: imageUrl, isReversed: false),
        bottom: showTabBar
            ? PreferredSize(
                preferredSize: Size.fromHeight(35.h),
                child: TabBar(
                  tabs: [
                    Tab(text: LocaleKeys.tabBarReview.tr()),
                    Tab(text: LocaleKeys.tabBarQuestion.tr()),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  static PreferredSize appBarWithActions({
    required BuildContext context,
    required String? imageUrl,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        45.h,
      ),
      child: AppBar(
        elevation: 3,
        backgroundColor: ColorManager.white,
        actions: AppBars.actions(
            context: context, imageUrl: imageUrl, isReversed: false),
        iconTheme: IconThemeData(
          color: ColorManager.black,
        ),
      ),
    );
  }

  static PreferredSize appBarWithTitle({
    required BuildContext context,
    required String title,
    double elevation = 3,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        45.h,
      ),
      child: AppBar(
        elevation: elevation,
        title: Text(
          title,
          style: TextStyleManager.s20w700.copyWith(color: ColorManager.black),
        ),
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(
          color: ColorManager.black,
        ),
      ),
    );
  }

  static PreferredSize appBarOfUserProfile({
    required BuildContext context,
    required String title,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        45.h,
      ),
      child: AppBar(
        elevation: 3,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 300.w,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyleManager.s20w700
                    .copyWith(color: ColorManager.black),
              ),
            ),
          ],
        ),
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(
          color: ColorManager.black,
        ),
      ),
    );
  }

  static PreferredSize appBarOfProductProfile({
    required BuildContext context,
    required TabController controller,
    required String text,
    required String? imageUrl,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        82.h,
      ),
      child: AppBar(
        elevation: 3,
        titleSpacing: 0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(
          color: ColorManager.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: AppBars.actions(
            context: context,
            imageUrl: imageUrl,
            isReversed: true,
          ).reversed.toList(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                top: 10.h,
                right: !context.isArabic ? 15.w : 0,
                left: !context.isArabic ? 0 : 15.w),
            child: SizedBox(
              width: 240.w,
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyleManager.s20w700
                    .copyWith(color: ColorManager.black),
              ),
            ),
          )
        ],
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(text: LocaleKeys.tabBarReviews.tr()),
            Tab(text: LocaleKeys.tabBarSpecs.tr()),
            Tab(text: LocaleKeys.tabBarQuestionsAndAnswers.tr()),
          ],
        ),
      ),
    );
  }

  static PreferredSize appBarOfCompnayProfile({
    required BuildContext context,
    required TabController controller,
    required String text,
    required String? imageUrl,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        82.h,
      ),
      child: AppBar(
        elevation: 3,
        titleSpacing: 0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(
          color: ColorManager.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: AppBars.actions(
            context: context,
            imageUrl: imageUrl,
            isReversed: true,
          ).reversed.toList(),
        ),
        actions: [
          SizedBox(
            width: 240.w,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 10.h,
                  right: !context.isArabic ? 15.w : 0,
                  left: !context.isArabic ? 0 : 15.w),
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyleManager.s20w700
                    .copyWith(color: ColorManager.black),
              ),
            ),
          )
        ],
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(text: LocaleKeys.tabBarReviews.tr()),
            Tab(text: LocaleKeys.tabBarQuestionsAndAnswers.tr()),
          ],
        ),
      ),
    );
  }

  static PreferredSize appBarofReportsScreen({
    required BuildContext context,
    required TabController controller,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        82.h,
      ),
      child: AppBar(
        elevation: 3,
        titleSpacing: 0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(
          color: ColorManager.black,
        ),
        title: Text(
          LocaleKeys.reports.tr(),
          style: TextStyleManager.s20w700.copyWith(color: ColorManager.black),
        ),
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(text: LocaleKeys.open.tr()),
            Tab(text: LocaleKeys.closed.tr()),
          ],
        ),
      ),
    );
  }

  // static SliverAppBar appBarWithFilters({
  //   required ValueChanged<ReviewsFilter> setFilter,
  //   required bool isMobileFilterPressed,
  //   required String title,
  // }) {
  //   return SliverAppBar(
  //     titleSpacing: 0,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         bottomLeft: Radius.circular(10.r),
  //         bottomRight: Radius.circular(10.r),
  //       ),
  //     ),
  //     backgroundColor: ColorManager.white,
  //     iconTheme: IconThemeData(
  //       color: ColorManager.black,
  //     ),
  //     elevation: 3,
  //     pinned: true,
  //     forceElevated: true,
  //     snap: true,
  //     floating: true,
  //     toolbarHeight: 45.h,
  //     collapsedHeight: 45.h,
  //     expandedHeight: 45.h,
  //     flexibleSpace: Row(
  //       children: [
  //         SizedBox(width: 17.w),
  //         TextButton(
  //           style: ButtonStyle(
  //             backgroundColor: isMobileFilterPressed
  //                 ? MaterialStateProperty.all<Color>(ColorManager.buttonGrey)
  //                 : MaterialStateProperty.all<Color>(ColorManager.white),
  //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //               RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(26.r),
  //                 side: BorderSide(color: ColorManager.buttonGrey),
  //               ),
  //             ),
  //           ),
  //           onPressed: () {
  //             setFilter(
  //               ReviewsFilter.phones,
  //             );
  //           },
  //           child: Text(
  //             LocaleKeys.phones.tr(),
  //             style: TextStyleManager.s14w700.copyWith(
  //               color: isMobileFilterPressed
  //                   ? ColorManager.white
  //                   : ColorManager.buttonGrey,
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 17.w),
  //         TextButton(
  //           style: ButtonStyle(
  //             backgroundColor: !isMobileFilterPressed
  //                 ? MaterialStateProperty.all<Color>(ColorManager.buttonGrey)
  //                 : MaterialStateProperty.all<Color>(ColorManager.white),
  //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //               RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(26.r),
  //                 side: BorderSide(color: ColorManager.buttonGrey),
  //               ),
  //             ),
  //           ),
  //           onPressed: () {
  //             setFilter(ReviewsFilter.companies);
  //           },
  //           child: Text(
  //             LocaleKeys.companies.tr(),
  //             style: TextStyleManager.s14w700.copyWith(
  //               color: !isMobileFilterPressed
  //                   ? ColorManager.white
  //                   : ColorManager.buttonGrey,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // static appBarWithCompaniesList() {
  //   return SliverAppBar(
  //     elevation: 3,
  //     title: SizedBox(
  //       height: 30.h,
  //       width: 95.w,
  //       child: Placeholder(),
  //     ),
  //     actions: [
  //       ElevatedButton(onPressed: () {}, child: Text('PROFILE')),
  //       ElevatedButton(onPressed: () {}, child: Text('SEARCH')),
  //     ],
  //     pinned: true,
  //     forceElevated: true,
  //     snap: true,
  //     floating: true,
  //     toolbarHeight: 45.h,
  //     collapsedHeight: 45.h,
  //     expandedHeight: 45.h + 95.h + 10.h,
  //     flexibleSpace: Padding(
  //       padding: EdgeInsets.only(top: 45.h),
  //       child: ListView(
  //         physics: NeverScrollableScrollPhysics(),
  //         children: [
  //           // CompanyHorizontalListTile(companyItems: companyItems),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
