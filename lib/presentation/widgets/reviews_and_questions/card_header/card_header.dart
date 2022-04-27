import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header_subtitle.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header_title.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header_trailer.dart';

/// Topmost part of the review.
class CardHeader extends StatelessWidget {
  const CardHeader({
    Key? key,
    required this.postedDate,
    required this.usedSinceDate,
    required this.views,
    required this.authorName,
    required this.imageUrl,
    required this.targetName,
      required this.cardType
  }) : super(key: key);

  /// Profile image url of the current logged in user.
  final String imageUrl;

  /// Name of review author.
  final String authorName;

  /// Name of product or company on which the review was posted.
  final String targetName;

  /// The date where the review was posted.
  final DateTime postedDate;

  /// The date from which the user started using the product.
  final DateTime? usedSinceDate;

  /// How many times this review was viewed.
  final int? views;

  final CardType cardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Avatar(
            imageUrl: imageUrl,
            radius: AppRadius.cardHeaderAvatarRadius,
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardHeaderTitle(
                  authorName: authorName,
                  productName: targetName,
                  cardType: cardType,
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
