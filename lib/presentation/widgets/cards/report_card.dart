import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    Key? key,
    required this.report,
    required this.reportStatus,
  }) : super(key: key);

  final Report report;
  final ReportStatus reportStatus;

  Widget _buildElevatedButton({
    required VoidCallback onPressed,
    required Color color,
    required String text,
  }) {
    return Flexible(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          textStyle: TextStyleManager.s14w700.copyWith(
            fontFamily: FontConstants.tajawal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppElevations.ev3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppRadius.interactionBodyRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 8.h, 0, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardHeader(
              imageUrl: report.reporterPicture,
              authorName: report.reporterName,
              targetName: report.reporteeName,
              postedDate: report.createdAt,
              userId: report.reporterId,
              targetId: report.reporteeId,
              targetType: null,
              postContentType: null,
              postId: null,
              views: null,
              usedSinceDate: null,
              usedInReportCard: true,
            ),
            20.verticalSpace,
            _buildReportBodyText(),
            8.verticalSpace,
            _buildReportButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildReportBodyText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${LocaleKeys.postType.tr()}: ',
                  style: TextStyleManager.s16w500,
                ),
                TextSpan(
                  text: '${report.type.translatedName}\n',
                  style: TextStyleManager.s16w400,
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${LocaleKeys.reason.tr()}: ',
                  style: TextStyleManager.s16w500,
                ),
                TextSpan(
                  text: '${report.reason.translatedName}\n',
                  style: TextStyleManager.s16w400,
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${LocaleKeys.complaintContent.tr()}: ',
                  style: TextStyleManager.s16w500,
                ),
                TextSpan(
                  text: '\n${report.info ?? '-'}',
                  style: TextStyleManager.s16w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildElevatedButton(
                onPressed: () {},
                color: ColorManager.blue,
                text: LocaleKeys.showContent.tr(),
              ),
              if (reportStatus == ReportStatus.open) ...[
                10.horizontalSpace,
                _buildElevatedButton(
                  onPressed: () {},
                  color: ColorManager.blue,
                  text: LocaleKeys.closeComplaint.tr(),
                ),
              ],
            ],
          ),
          8.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildElevatedButton(
                onPressed: () {},
                color: ColorManager.red,
                text: !report.contentHidden
                    ? LocaleKeys.hideThisContent.tr()
                    : LocaleKeys.letThisContentBeViewed.tr(),
              ),
              10.horizontalSpace,
              _buildElevatedButton(
                onPressed: () {},
                color: ColorManager.red,
                text: !report.reporteeBlocked
                    ? LocaleKeys.blockThisUsersAccount.tr()
                    : LocaleKeys.unblockThisUsersAccount.tr(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
