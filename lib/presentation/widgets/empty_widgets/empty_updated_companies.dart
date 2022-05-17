import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/text_style_manager.dart';

class EmptyUpdatedCompanies extends StatelessWidget {
  const EmptyUpdatedCompanies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Text(
          'لم يتم العثور على شركات جديدة',
          style: TextStyleManager.s20w500,
        ),
      ),
    );
  }
}
