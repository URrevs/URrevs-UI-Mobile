import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/about_us_screen.dart';

import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/admin_panel/admin_panel_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/privacy_policy_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/questions_about_my_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/settings_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/terms_and_conditions_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/owned_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_questions_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_posts_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_user_profile_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/partial_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/menu_profile_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/profile_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/invitation_code_and_link_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/sign_out_confirmation_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class MenuSubscreen extends ConsumerStatefulWidget {
  const MenuSubscreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MenuSubscreen> createState() => _MenuSubscreenState();
}

class _MenuSubscreenState extends ConsumerState<MenuSubscreen> {
  Widget _buildMyProfile() {
    ref.listen(getMyProfileProvider, (previous, next) {
      if (next is GetMyProfileErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.failure.message)),
        );
        if (next.failure is AuthenticateFailure) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AuthenticationScreen.routeName,
            (route) => false,
          );
        }
      }
    });
    return _buildMyProfileData();
  }

  Widget _buildMyProfileData() {
    final state = ref.watch(getMyProfileProvider);
    if (state is GetMyProfileInitialState ||
        state is GetMyProfileLoadingState) {
      return MenuProfileLoading();
    } else if (state is GetMyProfileErrorState) {
      return PartialErrorWidget(
        onRetry: ref.read(getMyProfileProvider.notifier).getMyProfile,
      );
    }
    final loadedState = state as GetMyProfileLoadedState;
    return _buildProfileData(
      picture: loadedState.user.picture,
      name: loadedState.user.name,
      points: loadedState.user.points,
    );
  }

  Widget _buildProfileData({
    String? picture,
    required String name,
    required int points,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(UserProfileScreen.routeName);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 20.w, left: 20.w),
        child: Row(
          children: [
            Avatar(
              imageUrl: picture,
              radius: 20.r,
            ),
            10.horizontalSpace,
            Expanded(
              child: Text(
                name,
                style: TextStyleManager.s20w700,
                textAlign: TextAlign.start,
              ),
            ),
            8.horizontalSpace,
            _buildCollectedStars(points),
          ],
        ),
      ),
    );
  }

  Row _buildCollectedStars(int stars) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Icon(
              IconsManager.star,
              color: ColorManager.blue,
              size: 40.sp,
            )),
        6.horizontalSpace,
        Text(
          stars.toString(),
          style: TextStyleManager.s20w400.copyWith(
            color: ColorManager.black,
          ),
        ),
      ],
    );
  }

  List<Widget> myProfileListItems() {
    return [
      ItemTile(
        title: LocaleKeys.myReviews.tr(),
        iconData: Icons.rate_review_outlined,
        onTap: () {
          Navigator.of(context).pushNamed(PostedPostsScreen.routeName);
        },
      ),
      ItemTile(
        title: LocaleKeys.myQuestions.tr(),
        iconData: Icons.question_answer_outlined,
        onTap: () {
          Navigator.of(context).pushNamed(PostedQuestionsScreen.routeName);
        },
      ),
      ItemTile(
        title: LocaleKeys.ownedProducts.tr(),
        iconData: Icons.devices_other_outlined,
        onTap: () {
          Navigator.of(context).pushNamed(OwnedProductsScreen.routeName);
        },
      ),
      ItemTile(
        title: LocaleKeys.questionsOnMyProducts.tr(),
        subtitle: LocaleKeys.helpOthersAndGetPoints.tr(),
        iconData: Icons.question_mark_outlined,
        onTap: () {
          Navigator.of(context)
              .pushNamed(QuestionsAboutMyProductsScreen.routeName);
        },
      ),
      _buildRefCodeTile(),
      //TODO: if not admin it won't be visible.
      ItemTile(
        title: LocaleKeys.adminPanel.tr(),
        iconData: Icons.admin_panel_settings_outlined,
        onTap: () {
          Navigator.of(context).pushNamed(AdminPanelScreen.routeName);
        },
      ),
      ItemTile(
        title: LocaleKeys.settings.tr(),
        iconData: Icons.settings_outlined,
        onTap: () {
          Navigator.of(context).pushNamed(SettingsScreen.routeName);
        },
      ),
      ItemTile(
        title: LocaleKeys.aboutUs.tr(),
        iconData: Icons.error_outline,
        onTap: () {
          Navigator.of(context).pushNamed(AboutUsScreen.routeName);
        },
      ),
      ItemTile(
        title: LocaleKeys.contactUs.tr(),
        iconData: Icons.contact_mail_outlined,
        onTap: () {
          _sendEmail();
        },
      ),
      ItemTile(
        title: LocaleKeys.logOut.tr(),
        iconData: Icons.logout_outlined,
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SignOutConfirmationDialog();
            },
          );
        },
      ),
    ];
  }

  Future _launchFacebookPage() async {
    /// this is the url of the app in the google play store
    String url = 'https://www.facebook.com/URrevs';
    final Uri _url = Uri.parse(url);
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future _launchLinkedinPage() async {
    /// this is the url of the app in the google play store
    String url = 'https://eg.linkedin.com/company/urrevs?trk=ppro_cprof';
    final Uri _url = Uri.parse(url);
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: StringsManager.emailAddress,
    );

    launchUrl(emailLaunchUri);
  }

  Widget _buildRefCodeTile() {
    final state = ref.watch(getMyProfileProvider);
    VoidCallback? onTap;
    if (state is GetMyProfileLoadedState) {
      onTap = () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return InvitationCodeDialog(
              invitationCode: state.refCode,
            );
          },
        );
      };
    }
    return ItemTile(
      title: LocaleKeys.yourInvitationCode.tr(),
      subtitle: LocaleKeys.inviteYourFriendsToWriteTheirReviews.tr(),
      iconData: Icons.groups_outlined,
      onTap: onTap,
    );
  }

  Widget _buildFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                LocaleKeys.followUs.tr(),
                style: TextStyleManager.s22w500,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.facebook,
                        color: Color(0xFF1372E6),
                        size: 40.sp,
                      ),
                      onPressed: () {
                        _launchFacebookPage();
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.linkedin,
                        color: Color(0xFF0A66C2),
                        size: 40.sp,
                      ),
                      onPressed: () {
                        _launchLinkedinPage();
                      },
                    ),
                  ]),
            )
          ],
        ),
        Spacer(),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(TermsAndConditionsScreen.routeName);
              },
              child: Text(
                LocaleKeys.termsOfUse.tr(),
                style: TextStyleManager.s16w400.copyWith(
                  color: ColorManager.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              ' | ',
              style: TextStyleManager.s16w400,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(PrivacyPolicyScreen.routeName);
              },
              child: Text(
                LocaleKeys.privacyPolicy.tr(),
                style: TextStyleManager.s16w400.copyWith(
                  color: ColorManager.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            4.horizontalSpace,
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () => ref.read(getMyProfileProvider.notifier).getMyProfile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.setLocale(LanguageType.ar.locale);
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      children: [
        _buildMyProfile(),
        ...myProfileListItems(),
        5.verticalSpace,
        _buildFooter(),
      ],
    ));
  }
}
