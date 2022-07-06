import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/post_loading.dart';

class PostListLoading extends StatelessWidget {
  const PostListLoading({
    Key? key,
    this.isQuestion = false,
  }) : super(key: key);

  final bool isQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      height: 1000.h,
      child: ListView(
        children: [
          for (int i = 0; i < 5; i++) ...[
            PostLoading(isQuestion: isQuestion),
            20.verticalSpace,
          ]
        ],
      ),
    );
  }
}
