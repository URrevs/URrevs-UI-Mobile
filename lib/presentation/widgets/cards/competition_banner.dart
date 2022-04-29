
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class CompetitionBanner extends StatelessWidget {
  const CompetitionBanner({
    required this.numberOfRemainingdays,
    required this.prizeName,
    Key? key,
  }) : super(key: key);

  /// number of remaining days of the competition.
  final int numberOfRemainingdays;

  /// name of the prize.
  final String prizeName;
  
  @override
  Widget build(BuildContext context) {
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
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyleManager.s22w500.copyWith(
                        color: ColorManager.white,
                        fontFamily: FontConstants.tajawal,
                      ),
                      children: [
                        TextSpan(text: numberOfRemainingdays.toString() +' '+ LocaleKeys.remainigDays.tr()),
                        TextSpan(text: '\n'),
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
                                color: ColorManager.white,
                                fontFamily: FontConstants.tajawal,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
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
                        color: ColorManager.white,
                      ),
                      reverseIcon: true,
                      width: 25.w,
                      onPressed: () {},
                    ),
                    GradButton(
                      text: Text(
                        LocaleKeys.inviteFriends.tr(),
                        style: TextStyleManager.s14w700,
                      ),
                      icon: Icon(
                        IconsManager.inviteFriends,
                        size: 28.sp,
                        color: ColorManager.white,
                      ),
                      width: 50.w,
                      reverseIcon: false,
                      onPressed: () {},
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
