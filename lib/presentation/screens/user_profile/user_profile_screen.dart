import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_user_profile_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/updated_list_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class UserProfileScreenArgs {
  bool otherUser;
  UserProfileScreenArgs({
    this.otherUser = false,
  });
}

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen(this.screenArgs, {Key? key}) : super(key: key);

  final UserProfileScreenArgs screenArgs;

  static const String routeName = 'UserProfileScreen';

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  Widget _buildCollectedStars({required int stars}) {
    final state = ref.watch(getMyProfileProvider);
    if (state is GetMyProfileLoadedState) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.collectedStars.tr(),
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
            stars.toString(),
            style: TextStyleManager.s20w400.copyWith(
              color: ColorManager.grey,
            ),
          ),
        ],
      );
    } else if (state is GetMyProfileLoadingState) {
      return Center(child: CircularProgressIndicator());
    } else if (state is GetMyProfileErrorState) {
      return Text(state.failure.message);
    } else {
      return SizedBox();
    }
  }

  List<Widget> myProfileListItems({required String refCode}) {
    return [
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
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Text(refCode),
            ),
          );
        },
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
  }

  List<Widget> get otherUserProfileListItems => [
        MenyItem(
          title: LocaleKeys.reviews.tr(),
          iconData: Icons.rate_review_outlined,
          onTap: () {
            Navigator.of(context).pushNamed(PostedReviewsScreen.routeName);
          },
        ),
        MenyItem(
          title: LocaleKeys.ownedProducts.tr(),
          iconData: Icons.question_answer_outlined,
          onTap: () {
            Navigator.of(context).pushNamed(OwnedProductsScreen.routeName);
          },
        ),
        MenyItem(
          title: LocaleKeys.askedQuestions.tr(),
          iconData: Icons.devices_other_outlined,
          onTap: () {
            Navigator.of(context).pushNamed(PostedQuestionsScreen.routeName);
          },
        ),
      ];

  String get imageUrl {
    if (widget.screenArgs.otherUser) return StringsManager.picsum200x200;
    firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user == null) throw UnsupportedError('user should have logged in');
    return user.photoURL!;
  }

  String get userName {
    if (widget.screenArgs.otherUser) return 'Other user';
    firebase_auth.User? user = firebase_auth.FirebaseAuth.instance.currentUser;
    if (user == null) throw UnsupportedError('user should have logged in');
    return user.displayName!;
  }

  Widget _buildBody() {
    final state = ref.watch(getMyProfileProvider);
    if (state is GetMyProfileLoadedState) {
      return ListView(
        children: [
          15.verticalSpace,
          Avatar(
            imageUrl: state.user.picture,
            radius: 45.r,
          ),
          10.verticalSpace,
          Text(
            state.user.name,
            style: TextStyleManager.s22w700,
            textAlign: TextAlign.center,
          ),
          8.verticalSpace,
          _buildCollectedStars(stars: state.user.points),
          22.verticalSpace,
          if (!widget.screenArgs.otherUser)
            ...myProfileListItems(refCode: state.refCode),
          if (widget.screenArgs.otherUser) ...otherUserProfileListItems
        ],
      );
    } else {
      return CircularLoading();
    }
  }

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
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: _buildBody(),
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
