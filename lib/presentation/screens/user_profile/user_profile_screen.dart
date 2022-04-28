import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/questions_about_my_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/owned_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_questions_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_reviews_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/updated_list_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  static const String routeName = 'UserProfileScreen';

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Row _buildCollectedStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'النجوم المجمعة',
          style: TextStyleManager.s20w400.copyWith(
            color: ColorManager.grey,
          ),
        ),
        12.horizontalSpace,
        Padding(
          padding: EdgeInsets.only(bottom: 6.h),
          child: SvgPicture.asset(
            SvgAssets.star,
            color: ColorManager.blue,
            height: 24.sp,
          ),
        ),
        6.horizontalSpace,
        Text(
          '40',
          style: TextStyleManager.s20w400.copyWith(
            color: ColorManager.grey,
          ),
        ),
      ],
    );
  }

  List<Widget> get menuItemsList => [
        MenyItem(
          title: LocaleKeys.myReviews.tr(),
          iconData: Icons.rate_review_outlined,
          onTap: () {
            Navigator.of(context).pushNamed(PostedReviewsScreen.routeName);
          },
        ),
        MenyItem(
          title: LocaleKeys.myQuestions.tr(),
          iconData: Icons.question_answer_outlined,
          onTap: () {
            Navigator.of(context).pushNamed(PostedQuestionsScreen.routeName);
          },
        ),
        MenyItem(
          title: LocaleKeys.ownedProducts.tr(),
          iconData: Icons.devices_other_outlined,
          onTap: () {
            Navigator.of(context).pushNamed(OwnedProductsScreen.routeName);
          },
        ),
        MenyItem(
          title: LocaleKeys.yourInvitationCode.tr(),
          subtitle: LocaleKeys.inviteYourFriendsToWriteTheirReviews.tr(),
          iconData: Icons.groups_outlined,
          // TODO: copy invitation code into user's clipboard
          onTap: () {},
        ),
        MenyItem(
          title: LocaleKeys.questionsOnMyProducts.tr(),
          subtitle: LocaleKeys.helpOthersAndGetPoints.tr(),
          iconData: Icons.question_mark_outlined,
          onTap: () {
            Navigator.of(context)
                .pushNamed(QuestionsAboutMyProductsScreen.routeName);
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                15.verticalSpace,
                Avatar(
                  imageUrl: StringsManager.picsum200x200,
                  radius: 45.r,
                ),
                10.verticalSpace,
                Text(
                  'Ziad Mostafa',
                  style: TextStyleManager.s22w700,
                ),
                8.verticalSpace,
                _buildCollectedStars(),
                22.verticalSpace,
                ...menuItemsList
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MenyItem extends StatelessWidget {
  const MenyItem({
    Key? key,
    required this.title,
    required this.iconData,
    required this.onTap,
    this.subtitle,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyleManager.s20w700),
      onTap: onTap,
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyleManager.s16w400.copyWith(
                color: ColorManager.grey,
              ),
            )
          : null,
      textColor: ColorManager.black,
      iconColor: ColorManager.buttonGrey,
      leading: Icon(
        iconData,
        size: 40.sp,
      ),
    );
  }
}
