import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/review_card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// A card showing a review for a product.
class CompanyReviewCard extends StatelessWidget {
  /// Name of review author.
  final String authorName;

  /// Profile image url of the current logged in user.
  final String imageUrl;

  /// Name of product on which the review was posted.
  final String companyName;

  /// The date where the review was posted.
  final DateTime postedDate;

  /// The date from which the user started using the product.
  final DateTime usedSinceDate;

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

  const CompanyReviewCard({
    Key? key,
    required this.postedDate,
    required this.usedSinceDate,
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
  }) : super(key: key);

  /// An instance of [CompanyReviewCard] filled with dummy data.
  static CompanyReviewCard get dummyInstance => CompanyReviewCard(
        postedDate: DateTime.now(),
        usedSinceDate: DateTime.now().subtract(Duration(days: 200)),
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
      );

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
      child: CircleAvatar(
        radius: AppRadius.questionMarkNotchRadius,
        backgroundColor: ColorManager.backgroundGrey,
        child: Transform.rotate(
          angle: 24 / 180 * pi * (context.isArabic ? -1 : 1),
          child: FaIcon(
            FontAwesomeIcons.circleQuestion,
            color: ColorManager.blue,
            size: 22.sp,
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
          elevation: 3,
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
                ),
                10.verticalSpace,
                ReviewCardBody(
                  prosText: prosText,
                  consText: consText,
                  ratingCriteria: _ratingCriteria,
                  scores: [generalRating],
                  showExpandCircle: false,
                  hideSeeMoreIfNoNeedForExpansion: true,
                ),
                10.verticalSpace,
                CardFooter(
                  likeCount: likeCount,
                  commentCount: commentCount,
                  shareCount: shareCount,
                  liked: liked,
                  useInReviewCard: true,
                  onLike: _onLike,
                  onComment: _onComment,
                  onShare: _onShare,
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
