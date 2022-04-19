import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header_avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header_subtitle.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header_title.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header_trailer.dart';

/// Topmost part of the review.
class CardHeader extends StatelessWidget {
  const CardHeader({
    Key? key,
    required this.postedDate,
    this.usedSinceDate,
    required this.views,
    required this.authorName,
    required this.imageUrl,
    required this.productName,
  }) : super(key: key);

  /// Profile image url of the current logged in user.
  final String imageUrl;

  /// Name of review author.
  final String authorName;

  /// Name of product on which the review was posted.
  final String productName;

  /// The date where the review was posted.
  final DateTime postedDate;

  /// The date from which the user started using the product.
  final DateTime? usedSinceDate;

  /// How many times this review was viewed.
  final int views;

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
