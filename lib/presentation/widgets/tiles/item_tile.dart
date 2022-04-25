
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            'Xiaomi Redmi Note 6',
            style: TextStyleManager.s20w700,
          ),
          textColor: ColorManager.black,
          iconColor: ColorManager.buttonGrey,
          subtitle: Text('هاتف ذكي',
              style: TextStyleManager.s18w400.copyWith(
                color: ColorManager.grey,
              )),
          leading: Icon(
            Icons.smartphone_rounded,
            size: 40.sp,
          ),
        ),
        Divider(
          indent: 20.w,
          endIndent: 20.w,
          color: ColorManager.dividerGrey,
          thickness: 1.h,)
      ],
    );
  }
}