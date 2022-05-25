import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/prize_photo_dialog.dart';

class LeaderboardEntryTile extends StatelessWidget {
  const LeaderboardEntryTile({
    required this.name,
    required this.isWinner,
    required this.userImageUrl,
    required this.rank,
    required this.starsCounter,
    required this.prizeName,
    required this.prizeImageUrl,
    Key? key,
  }) : super(key: key);
  final String name;
  final bool isWinner;
  final String? userImageUrl;
  final int rank;
  final int starsCounter;
  final String prizeName;
  final String prizeImageUrl;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.updatedListTile),
      ),
      child: LeaderboardEntryData(
        rank: rank,
        onTap: () {},
        userImageUrl: userImageUrl,
        name: name,
        isWinner: isWinner,
        starsCounter: starsCounter,
        prizeName: prizeName,
        prizeImageUrl: prizeImageUrl,
      ),
    );
  }
}

class LeaderboardEntryData extends StatelessWidget {
  const LeaderboardEntryData({
    Key? key,
    required this.rank,
    required this.userImageUrl,
    required this.name,
    required this.isWinner,
    required this.starsCounter,
    required this.onTap,
    required this.prizeName,
    required this.prizeImageUrl,
  }) : super(key: key);

  final int rank;
  final String? userImageUrl;
  final String name;
  final bool isWinner;
  final int starsCounter;
  final VoidCallback? onTap;
  final String prizeName;
  final String prizeImageUrl;

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat =
        NumberFormat.compact(locale: context.locale.languageCode);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 12.5.h),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: ColorManager.backgroundGrey,
              radius: 18.r,
              child: Center(
                child: FittedBox(
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h, right: 4.w, left: 4.w),
                    child: Text(
                      numberFormat.format(rank),
                      style: TextStyleManager.s18w700
                          .copyWith(color: ColorManager.black),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 5.w),
            Avatar(
              imageUrl: userImageUrl,
              radius: 20.r,
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyleManager.s20w700,
                ),
              ),
            ),
            isWinner ? SizedBox(width: 3.w) : SizedBox(),
            isWinner
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PrizePhotoDialog(
                            prizeName: prizeName,
                            imageUrl: prizeImageUrl,
                          );
                        },
                      );
                    },
                    child: Icon(
                      FontAwesomeIcons.gift,
                      size: 30.sp,
                      color: ColorManager.golden,
                    ),
                  )
                : SizedBox(),
            SizedBox(width: 3.w),
            Icon(
              IconsManager.star,
              size: 40.sp,
              color: ColorManager.blue,
            ),
            SizedBox(width: 3.w),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: EdgeInsets.only(top: 7.h),
                child: Text(
                  numberFormat.format(starsCounter),
                  style: TextStyleManager.s18w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
