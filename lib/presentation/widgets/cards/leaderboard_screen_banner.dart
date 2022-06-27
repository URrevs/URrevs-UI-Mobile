import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/txt_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/how_to_collect_points_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/how_to_win_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/invitation_code_and_link_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class LeaderboardScreenBanner extends ConsumerWidget {
  const LeaderboardScreenBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        elevation: 3,
        shadowColor: ColorManager.black.withOpacity(0.5).withOpacity(0.5),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Text(
                      LocaleKeys.helpOthersToCollectPoints.tr(),
                      style: TextStyleManager.s22w500,
                      textAlign: TextAlign.center,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TxtButton(
                      text: Text(
                        LocaleKeys.howToCollectPoints.tr(),
                        style: TextStyleManager.s14w700.copyWith(
                          color: ColorManager.white,
                        ),
                      ),
                      icon: Icon(
                        IconsManager.howTowin,
                        size: 28.sp,
                        color: ColorManager.white,
                      ),
                      reverseIcon: true,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return HowToCollectPointsDialog();
                          },
                        );
                      },
                    ),
                    TxtButton(
                      text: Text(
                        LocaleKeys.inviteFriends.tr(),
                        style: TextStyleManager.s14w700.copyWith(
                          color: ColorManager.white,
                        ),
                      ),
                      icon: Icon(
                        IconsManager.inviteFriends,
                        size: 28.sp,
                        color: ColorManager.white,
                      ),
                      reverseIcon: false,
                      onPressed: () {
                        final state = ref.watch(authenticationProvider)
                            as AuthenticationLoadedState;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return InvitationCodeDialog(
                              invitationCode: state.refCode,
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
