import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimilarPhonesLoading extends StatelessWidget {
  const SimilarPhonesLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(50.sp),
        child: Text('تحميل...'),
      ),
    );
  }
}