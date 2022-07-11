import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/how_to_win_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/invitation_code_and_link_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/prize_photo_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class CompetitionBanner extends ConsumerWidget {
  const CompetitionBanner({
    required this.deadline,
    required this.prizeName,
    required this.prizeUrl,
    Key? key,
  }) : super(key: key);

  final DateTime deadline;

  /// name of the prize.
  final String prizeName;

  final String prizeUrl;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      child: GradientCard(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        gradient: LinearGradient(
          colors: [
            ColorManager.blue,
            ColorManager.cyan,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
                child: Column(
                  children: [
                    CompetitionDeadline(deadline: deadline),
                    5.verticalSpace,
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyleManager.s22w500.copyWith(
                          color: ColorManager.competitionBannerTextColor,
                          fontFamily: FontConstants.tajawal,
                        ),
                        children: [
                          TextSpan(text: LocaleKeys.thePrizeIs.tr()),
                          TextSpan(text: '\n'),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: GestureDetector(
                              child: Text(
                                prizeName,
                                style: TextStyleManager.s22w900.copyWith(
                                  decoration: TextDecoration.underline,
                                  color:
                                      ColorManager.competitionBannerTextColor,
                                  fontFamily: FontConstants.tajawal,
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return PrizePhotoDialog(
                                      prizeName: prizeName,
                                      imageUrl: prizeUrl,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradButton(
                      text: Text(
                        LocaleKeys.howToWin.tr(),
                        style: TextStyleManager.s14w700,
                      ),
                      icon: Icon(
                        IconsManager.howTowin,
                        size: 28.sp,
                        color: ColorManager.elevatedButtonTextColor,
                      ),
                      reverseIcon: true,
                      width: 25.w,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return HowToWinDialog();
                          },
                        );
                      },
                    ),
                    GradButton(
                      text: Text(
                        LocaleKeys.inviteFriends.tr(),
                        style: TextStyleManager.s14w700,
                      ),
                      icon: Icon(
                        IconsManager.inviteFriends,
                        size: 28.sp,
                        color: ColorManager.elevatedButtonTextColor,
                      ),
                      width: 50.w,
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

class CompetitionDeadline extends StatefulWidget {
  const CompetitionDeadline({
    Key? key,
    required this.deadline,
  }) : super(key: key);

  final DateTime deadline;

  @override
  State<CompetitionDeadline> createState() => _CompetitionDeadlineState();
}

class _CompetitionDeadlineState extends State<CompetitionDeadline> {
  late String _remainingTime;
  late Timer _timer;

  void setRemainingTime() {
    Duration remainingDuration = widget.deadline.difference(DateTime.now());
    setState(() {
      if (remainingDuration.inDays > 0) {
        _remainingTime =
            '${remainingDuration.inDays} ${LocaleKeys.day.tr()} ${LocaleKeys.tillCompetitionEnds.tr()}';
      } else if (remainingDuration.inHours > 0) {
        _remainingTime =
            '${remainingDuration.inHours} ${LocaleKeys.hour.tr()} ${LocaleKeys.tillCompetitionEnds.tr()}';
      } else if (remainingDuration.inMinutes > 0) {
        _remainingTime =
            '${remainingDuration.inMinutes} ${LocaleKeys.minute.tr()} ${LocaleKeys.tillCompetitionEnds.tr()}';
      } else if (!remainingDuration.isNegative) {
        _remainingTime =
            '${LocaleKeys.lessThanAMinute.tr()} ${LocaleKeys.tillCompetitionEnds.tr()}';
      } else {
        _remainingTime = LocaleKeys.competitionEnded.tr();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setRemainingTime();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setRemainingTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        _remainingTime,
        textAlign: TextAlign.center,
        style: TextStyleManager.s22w500.copyWith(
          color: ColorManager.competitionBannerTextColor,
          fontFamily: FontConstants.tajawal,
        ),
      ),
    );
  }
}
