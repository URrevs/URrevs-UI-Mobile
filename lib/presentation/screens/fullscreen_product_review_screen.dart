import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comments_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';

class FullscreenProductReviewScreen extends StatefulWidget {
  const FullscreenProductReviewScreen({Key? key}) : super(key: key);

  static const String routeName = 'FullscreenProductReviewScreen';

  @override
  State<FullscreenProductReviewScreen> createState() =>
      _FullscreenProductReviewScreenState();
}

class _FullscreenProductReviewScreenState
    extends State<FullscreenProductReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarWithActions(context: context),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              children: [
                ProductReviewCard.dummyInstance,
                20.verticalSpace,
                CommentsList.dummyInstance,
              ],
            ),
          ),
          Container(
            color: ColorManager.white,
            child: TextField(),
          )
        ],
      ),
    );
  }
}
