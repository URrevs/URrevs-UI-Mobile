import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_header_avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_header_subtitle.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_header_title.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_header_trailer.dart';

/// Topmost part of the review.
class CardHeader extends StatelessWidget {
  const CardHeader({
    Key? key,
    required this.postedDate,
    required this.usedSinceDate,
    required this.views,
    required this.authorName,
    required this.imageUrl,
    required this.productName,
  }) : super(key: key);

  // Declared before in the ProductReviewCard
  final DateTime postedDate;
  final DateTime usedSinceDate;
  final int views;
  final String authorName;
  final String imageUrl;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          CardHeaderAvatar(imageUrl: imageUrl),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardHeaderTitle(
                  authorName: authorName,
                  productName: productName,
                ),
                CardHeaderSubtitle(
                  postedDate: postedDate,
                  usedSinceDate: usedSinceDate,
                  views: views,
                ),
              ],
            ),
          ),
          CardHeaderTrailer(onHatingThis: () {}),
        ],
      ),
    );
  }
}
