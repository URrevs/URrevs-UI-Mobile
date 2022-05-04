
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// A widget that shows a dialog with a photo of a prize.
class PrizePhotoDialog extends StatelessWidget {
  const PrizePhotoDialog({
    required this.prizeName,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  /// The name of the prize.
  final String prizeName;

  /// The url of the prize image.
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: LocaleKeys.competitionPrize.tr(),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            prizeName,
            style: TextStyleManager.s22w900.copyWith(
              color: ColorManager.black,
              fontFamily: FontConstants.tajawal,
            ),
          ),
          SizedBox(height: 10.h, width: 350.w),
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                errorBuilder: (context, exception, stackTrace) {
                  return Image.asset(
                    ImageAssets.errorImage,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
