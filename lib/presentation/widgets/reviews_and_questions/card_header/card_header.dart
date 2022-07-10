import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
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
    required this.userId,
    required this.targetId,
    required this.postId,
    required this.targetType,
    required this.postContentType,
    this.verificationRatio,
    this.usedInReportCard = false,
  })  : assert(usedInReportCard || targetType != null),
        assert(usedInReportCard || postId != null),
        assert(usedInReportCard || postContentType != null),
        super(key: key);

  /// Profile image url of the current logged in user.
  final String? imageUrl;

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

  final String userId;

  final String targetId;
  final String? postId;

  final TargetType? targetType;
  final PostContentType? postContentType;
  final bool usedInReportCard;
  final double? verificationRatio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Avatar(
            imageUrl: imageUrl,
            radius: AppRadius.cardHeaderAvatarRadius,
            onTap: () {
              Navigator.of(context).pushNamed(
                UserProfileScreen.routeName,
                arguments: UserProfileScreenArgs(userId: userId),
              );
            },
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardHeaderTitle(
                  authorName: authorName,
                  targetName: targetName,
                  targetId: targetId,
                  type: targetType,
                  userId: userId,
                  usedInReportCard: usedInReportCard,
                ),
                CardHeaderSubtitle(
                  postedDate: postedDate,
                  usedSinceDate: usedSinceDate,
                  views: views,
                  verificationRatio: verificationRatio,
                ),
              ],
            ),
          ),
          if (!usedInReportCard)
            CardHeaderTrailer(
              postContentType: postContentType!,
              postId: postId!,
              targetType: targetType!,
              userId: userId,
              targetId: targetId,
              verificationRatio: verificationRatio,
            ),
        ],
      ),
    );
  }
}
