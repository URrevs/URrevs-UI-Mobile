import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.sp),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
