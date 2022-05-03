import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';

import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/questions_about_my_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/owned_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_questions_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_reviews_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_user_profile_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_the_profile_of_another_user_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/partial_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/profile_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/error_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// [userId] is the id of an unauthenticated user whose profile is to be shown.
/// This field would be null if we would view the profile of the currently
/// authenticated user.
class UserProfileScreenArgs {
  String? userId;
  UserProfileScreenArgs({
    this.userId,
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
  bool get otherUser => widget.screenArgs.userId != null;

  List<Widget> myProfileListItems() {
    return [
      ItemTile(
        title: LocaleKeys.myReviews.tr(),
        iconData: Icons.rate_review_outlined,
        onTap: () {
          Navigator.of(context).pushNamed(PostedReviewsScreen.routeName);
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
      _buildRefCodeTile(),
      ItemTile(
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

  Widget _buildRefCodeTile() {
    final state = ref.watch(getMyProfileProvider);
    VoidCallback? onTap;
    if (state is GetMyProfileLoadedState) {
      onTap = () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Text(state.refCode),
          ),
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

  List<Widget> get otherUserProfileListItems => [
        ItemTile(
          title: LocaleKeys.reviews.tr(),
          iconData: Icons.rate_review_outlined,
          onTap: () {
            Navigator.of(context).pushNamed(PostedReviewsScreen.routeName);
          },
        ),
        ItemTile(
          title: LocaleKeys.ownedProducts.tr(),
          iconData: Icons.question_answer_outlined,
          onTap: () {
            Navigator.of(context).pushNamed(
              OwnedProductsScreen.routeName,
              arguments: OwnedProductsScreenArgs(
                userId: '626b29227fe7587a42e3e9f6', // Loai AL_Jolani
              ),
            );
          },
        ),
        ItemTile(
          title: LocaleKeys.askedQuestions.tr(),
          iconData: Icons.devices_other_outlined,
          onTap: () {
            Navigator.of(context).pushNamed(PostedQuestionsScreen.routeName);
          },
        ),
      ];

  Row _buildCollectedStars(int stars) {
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
  }

  ListView _buildProfile({
    required String? imageUrl,
    required String username,
    required int stars,
    required String? refCode,
  }) {
    return ListView(
      children: [
        _buildProfileData(),
        22.verticalSpace,
        if (!otherUser) ...myProfileListItems(),
        if (otherUser) ...otherUserProfileListItems
      ],
    );
  }

  Widget _buildProfileData() {
    final state = ref.watch(getMyProfileProvider);
    if (state is GetMyProfileInitialState ||
        state is GetMyProfileLoadingState) {
      return ProfileLoading();
    } else if (state is GetMyProfileErrorState) {
      return PartialErrorWidget(
        onRetry: ref.read(getMyProfileProvider.notifier).getMyProfile,
      );
    }
    final loadedState = state as GetMyProfileLoadedState;
    return Column(
      children: [
        15.verticalSpace,
        Avatar(
          imageUrl: loadedState.user.picture,
          radius: 45.r,
        ),
        10.verticalSpace,
        Text(
          loadedState.user.name,
          style: TextStyleManager.s22w700,
          textAlign: TextAlign.center,
        ),
        8.verticalSpace,
        _buildCollectedStars(loadedState.user.points),
      ],
    );
  }

  StatelessWidget _buildMyProfile() {
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
    return _buildProfile(
      imageUrl: '',
      username: '',
      stars: 0,
      refCode: '',
    );
  }

  StatelessWidget _buildAnotherUserProfile() {
    final state = ref.watch(getTheProfileOfAnotherUserProvider);
    if (state is GetTheProfileOfAnotherUserLoadedState) {
      return _buildProfile(
        imageUrl: state.user.picture,
        username: state.user.name,
        stars: state.user.points,
        refCode: null,
      );
    } else {
      return CircularLoading();
    }
  }

  Widget _buildBody() {
    if (!otherUser) {
      return _buildMyProfile();
    } else {
      return _buildAnotherUserProfile();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        if (!otherUser) {
          ref.read(getMyProfileProvider.notifier).getMyProfile();
        } else {
          ref
              .read(getTheProfileOfAnotherUserProvider.notifier)
              .getTheProfileOfAnotherUser(widget.screenArgs.userId!);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<GetTheProfileOfAnotherUserState>(
        getTheProfileOfAnotherUserProvider, (previous, next) {
      if (next is GetTheProfileOfAnotherUserErrorState) {
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(failure: next.failure),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }
}
