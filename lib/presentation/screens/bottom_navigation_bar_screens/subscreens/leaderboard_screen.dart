import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/competition_banner.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/leaderboard_screen_banner.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/leaderboard_entry_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class LeaderboardSubscreen extends StatefulWidget {
  const LeaderboardSubscreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardSubscreen> createState() => _LeaderboardSubscreenState();
}

class _LeaderboardSubscreenState extends State<LeaderboardSubscreen> {
  bool isCompetitionActive = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppEdgeInsets.screenPadding.copyWith(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          isCompetitionActive?CompetitionBanner(
              numberOfRemainingdays: 12, prizeName: 'Xiaomi Mi Band 5'):
              LeaderboardScreenBanner(),
          SizedBox(height: 10.h),
          Text(
            LocaleKeys.yourRanking.tr(),
            style: TextStyleManager.s18w700,
          ),
          LeaderboardEntryTile(
            name: 'Ziad Mostafa',
            isWinner: true,
            imageUrl: StringsManager.imagePlaceHolder,
            rank: 30,
            starsCounter: 50,
          ),
          SizedBox(height: 10.h),
          Text(LocaleKeys.usersRanking.tr(), style: TextStyleManager.s18w700),
          // users ranking card
          ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: Card(
              elevation: AppElevations.ev3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppRadius.updatedListTile,
                ),
              ),
              child: SizedBox(
                height: 380.h,
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                        thickness: 0.5,
                        color: ColorManager.dividerGrey,
                        indent: 10.w,
                        endIndent: 10.w),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return LeaderboardEntryData(
                          rank: index + 1,
                          imageUrl: StringsManager.imagePlaceHolder,
                          name: StringsManager.fakeName,
                          isWinner: false,
                          starsCounter: 40);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
