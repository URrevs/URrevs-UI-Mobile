import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/auth_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/urrevs_logo.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AuthenticationScreen extends ConsumerStatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  static const String routeName = 'AuthenticationScreen';

  @override
  ConsumerState<AuthenticationScreen> createState() =>
      _AuthenticationScreenState();
}

class _AuthenticationScreenState extends ConsumerState<AuthenticationScreen> {
  Align _buildLanguageButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shadowColor: ColorManager.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 12.h,
            ),
            textStyle: TextStyleManager.s14w700.copyWith(
              fontFamily: FontConstants.tajawal,
            ),
          ),
          child: Text('English'),
        ),
      ),
    );
  }

  Widget _buildAuthenticationButtons() {
    final state = ref.watch(authenticationProvider);
    if (state is AuthenticationLoadingState) {
      return SizedBox(
        height: 100.h,
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (state is AuthenticationErrorState) {
      return Text('Error');
    }
    return Column(
      children: [
        AuthButton(
          text: LocaleKeys.googleAuth.tr(),
          imagePath: SvgAssets.googleLogo,
          color: ColorManager.grey,
          onPressed:
              ref.read(authenticationProvider.notifier).authenticateWithGoogle,
        ),
        35.verticalSpace,
        AuthButton(
          text: LocaleKeys.facebookAuth.tr(),
          imagePath: SvgAssets.facebookLogo,
          color: ColorManager.blue,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLanguageButton(),
            80.verticalSpace,
            URrevsLogo(),
            80.verticalSpace,
            _buildAuthenticationButtons(),
          ],
        ),
      ),
    );
  }
}
