import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/review_card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// A card showing a review for a product.
class ProductReviewCard extends StatelessWidget {
  /// Profile image url of the current logged in user.
  final String imageUrl;

  /// Name of review author.
  final String authorName;

  /// Name of product on which the review was posted.
  final String productName;

  /// The date where the review was posted.
  final DateTime postedDate;

  /// The date from which the user started using the product.
  final DateTime usedSinceDate;

  /// How many times this review was viewed.
  final int views;

  /// The seven rating criteria show in a product review card.
  final List<String> _ratingCriteria = const [
    LocaleKeys.generalProductRating,
    LocaleKeys.userInterface,
    LocaleKeys.manufacturingQuality,
    LocaleKeys.priceQuality,
    LocaleKeys.camera,
    LocaleKeys.callsQuality,
    LocaleKeys.battery,
  ];

  /// List of scores the product is given by the review author.
  /// It is a list of 7 integers representing the rating from 1 to 5 for each
  /// rating criteria.
  final List<int> scores;

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

  const ProductReviewCard({
    Key? key,
    required this.postedDate,
    required this.usedSinceDate,
    required this.views,
    required this.authorName,
    required this.imageUrl,
    required this.productName,
    required this.scores,
    required this.prosText,
    required this.consText,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.liked,
  }) : super(key: key);

  /// An instance of [ProductReviewCard] filled with dummy data.
  static ProductReviewCard get dummyInstance => ProductReviewCard(
        postedDate: faker.date.dateTime(minYear: 2000, maxYear: 2022),
        usedSinceDate: faker.date.dateTime(minYear: 2000, maxYear: 2021),
        views: DummyDataManager.randomInt,
        authorName: faker.person.name(),
        imageUrl: StringsManager.picsum200x200,
        productName: 'Oppo Reno 5',
        scores: List.generate(7, (_) => Random().nextInt(5) + 1),
        prosText: StringsManager.lorem,
        consText: StringsManager.longestReviewCons,
        likeCount: DummyDataManager.randomInt,
        commentCount: DummyDataManager.randomInt,
        shareCount: DummyDataManager.randomInt,
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

  @override
  Widget build(BuildContext context) {
    return Card(
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
              targetName: productName,
              postedDate: postedDate,
              usedSinceDate: usedSinceDate,
              views: views,
            ),
            10.verticalSpace,
            ReviewCardBody(
              ratingCriteria: _ratingCriteria,
              scores: scores,
              prosText: prosText,
              consText: consText,
              showExpandCircle: true,
              hideSeeMoreIfNoNeedForExpansion: false,
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
    );
  }
}
