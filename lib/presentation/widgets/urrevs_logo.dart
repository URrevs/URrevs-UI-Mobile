
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';



class URrevsLogo extends StatelessWidget {
  const URrevsLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            ImageAssets.fullLogo,
            width: 180.w,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: 256.w,
            child: Text(
              LocaleKeys.brandBriefing.tr(),
              style: TextStyleManager.s18w500.copyWith(color: ColorManager.grey), 
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}