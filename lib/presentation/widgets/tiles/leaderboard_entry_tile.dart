
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';

class LeaderboardEntryTile extends StatelessWidget {
  const LeaderboardEntryTile({
    required this.name,
    required this.imageUrl,
    required this.rank,
    required this.starsCounter,
    Key? key,
  }) : super(key: key);
  final String name;
  final String imageUrl;
  final int rank;
  final int starsCounter;
  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat =
        NumberFormat.compact(locale: context.locale.languageCode);
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.updatedListTile),
        ),
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
                imageUrl: imageUrl,
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
        ));
  }
}