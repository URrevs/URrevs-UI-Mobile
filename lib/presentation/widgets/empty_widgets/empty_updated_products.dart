import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class EmptyUpdatedProducts extends StatelessWidget {
  const EmptyUpdatedProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Text(
          'لم يتم العثور على منتجات جديدة',
          style: TextStyleManager.s20w500,
        ),
      ),
    );
  }
}
