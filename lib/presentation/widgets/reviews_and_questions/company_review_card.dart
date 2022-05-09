import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/company_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/review_card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// A card showing a review for a product.
class CompanyReviewCard extends StatelessWidget {
  final String reviewId;

  /// Name of review author.
  final String authorName;

  /// Profile image url of the current logged in user.
  final String? imageUrl;

  /// Name of product on which the review was posted.
  final String companyName;

  /// The date where the review was posted.
  final DateTime postedDate;

  /// How many times this review was viewed.
  final int views;

  /// The single rating criteria shown in a company review card.
  final List<String> _ratingCriteria = const [LocaleKeys.companyRating];

  /// An integer from 1 to 5 representing the company general rating
  final int generalRating;

  /// The text which the user written in the pros section when submitting the
  /// review.
  final String prosText;

  /// The text which the user written in the cons section when submitting the
  /// review.
  final String consText;

  /// Is the review liked by the current logged in user or not.
  final bool liked;

  /// Number of likes given to the review.
  final int likeCount;

  /// Number of comments on the review.
  final int commentCount;

  /// Number of shares to the review
  final int shareCount;

  final bool fullscreen;

  final VoidCallback onPressingComment;

  final String userId;

  final String companyId;

  const CompanyReviewCard({
    Key? key,
    required this.reviewId,
    required this.userId,
    required this.companyId,
    required this.postedDate,
    required this.views,
    required this.authorName,
    required this.imageUrl,
    required this.companyName,
    required this.generalRating,
    required this.prosText,
    required this.consText,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.liked,
    required this.fullscreen,
    required this.onPressingComment,
  }) : super(key: key);

  CompanyReviewCard.fromCompanyReview({
    required CompanyReview companyReview,
    required this.fullscreen,
    required this.onPressingComment,
    Key? key,
  })  : reviewId = companyReview.id,
        userId = companyReview.userId,
        companyId = companyReview.targetId,
        postedDate = companyReview.createdAt,
        views = companyReview.views,
        authorName = companyReview.userName,
        imageUrl = companyReview.photo,
        companyName = companyReview.targetName,
        generalRating = companyReview.generalRating.toInt(),
        prosText = companyReview.pros,
        consText = companyReview.cons,
        likeCount = companyReview.likes,
        commentCount = companyReview.commentsCount,
        shareCount = companyReview.shares,
        liked = companyReview.liked,
        super(key: key);

  /// An instance of [CompanyReviewCard] filled with dummy data.
  static CompanyReviewCard dummyInstance({bool fullscreen = false}) =>
      CompanyReviewCard(
        reviewId: DateTime.now().microsecondsSinceEpoch.toString(),
        userId: DateTime.now().microsecondsSinceEpoch.toString(),
        companyId: DateTime.now().microsecondsSinceEpoch.toString(),
        postedDate: DateTime.now(),
        views: 100,
        authorName: faker.person.name(),
        imageUrl: StringsManager.picsum200x200,
        companyName: faker.company.name(),
        generalRating: Random().nextInt(5) + 1,
        prosText: StringsManager.lorem,
        consText: StringsManager.lorem,
        likeCount: 100,
        commentCount: 5,
        shareCount: 20,
        liked: Random().nextBool(),
        fullscreen: fullscreen,
        onPressingComment: () {},
      );

  CompanyReviewCard copyWith({
    String? reviewId,
    String? userId,
    String? companyId,
    String? imageUrl,
    String? authorName,
    String? companyName,
    DateTime? postedDate,
    DateTime? usedSinceDate,
    int? views,
    int? generalRating,
    String? prosText,
    String? consText,
    bool? liked,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    bool? fullscreen,
    VoidCallback? onPressingComment,
  }) {
    return CompanyReviewCard(
      reviewId: reviewId ?? this.reviewId,
      userId: userId ?? this.userId,
      companyId: companyId ?? this.companyId,
      postedDate: postedDate ?? this.postedDate,
      views: views ?? this.views,
      authorName: authorName ?? this.authorName,
      imageUrl: imageUrl ?? this.imageUrl,
      companyName: companyName ?? this.companyName,
      generalRating: generalRating ?? this.generalRating,
      prosText: prosText ?? this.prosText,
      consText: consText ?? this.consText,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      liked: liked ?? this.liked,
      fullscreen: fullscreen ?? this.fullscreen,
      onPressingComment: onPressingComment ?? this.onPressingComment,
    );
  }

  /// Callback invoked when like (or upvote) buttons are pressed.
  void _onLike() {
    // TODO: implememnt _onLike
  }

  /// Callback invoked when comment (or answer) buttons are pressed.
  void _onComment() {
    // TODO: implememnt _onComment
  }

  /// Callback invoked when share button is pressed.
  void _onShare() {
    // TODO: implememnt _onShare
  }

  Positioned _buildQuestionMark(BuildContext context) {
    return Positioned(
      top: 0,
      left: context.isArabic ? 0 : null,
      right: context.isArabic ? null : 0,
      child: Tooltip(
        message: LocaleKeys.companyReview.tr(),
        child: CircleAvatar(
          radius: AppRadius.questionMarkNotchRadius,
          backgroundColor: ColorManager.backgroundGrey,
          child: Transform.rotate(
            angle: 24 / 180 * pi * (context.isArabic ? -1 : 1),
            child: Container(
              height: 22.sp,
              width: 22.sp,
              alignment: Alignment.center,
              padding: EdgeInsets.all(1.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 2.r),
              ),
              child: Icon(
                IconsManager.review,
                color: ColorManager.blue,
                size: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: AppElevations.ev3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.interactionBodyRadius,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              children: [
                CardHeader(
                  imageUrl: imageUrl,
                  authorName: authorName,
                  targetName: companyName,
                  postedDate: postedDate,
                  usedSinceDate: null,
                  views: views,
                  cardType: CardType.companyReview,
                  userId: userId,
                  targetId: companyId,
                  type: TargetType.company,
                ),
                10.verticalSpace,
                ReviewCardBody(
                  prosText: prosText,
                  consText: consText,
                  ratingCriteria: _ratingCriteria,
                  scores: [generalRating],
                  showExpandCircle: false,
                  hideSeeMoreIfNoNeedForExpansion: true,
                  cardType: CardType.companyReview,
                  fullscreen: fullscreen,
                ),
                8.verticalSpace,
                CardFooter(
                  likeCount: likeCount,
                  commentCount: commentCount,
                  shareCount: shareCount,
                  liked: liked,
                  useInReviewCard: true,
                  onLike: _onLike,
                  onComment: onPressingComment,
                  onShare: _onShare,
                  cardType: CardType.companyReview,
                  fullscreen: fullscreen,
                  postType: PostType.companyReview,
                  postId: reviewId,
                ),
              ],
            ),
          ),
        ),
        _buildQuestionMark(context)
      ],
    );
  }
}
