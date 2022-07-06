import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class EmptyUpdatedProducts extends StatelessWidget {
  const EmptyUpdatedProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Text(
          LocaleKeys.noNewProductsFound.tr(),
          style: TextStyleManager.s20w500,
        ),
      ),
    );
  }
}
