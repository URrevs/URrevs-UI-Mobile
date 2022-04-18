import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_footer.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/company_review_card.dart';


/// A card showing a review for a product.
class ProductReviewCard extends StatelessWidget {
  /// The date where the review was posted.
  final DateTime postedDate;

  /// The date from which the user started using the product.
  final DateTime usedSinceDate;

  /// How many times this review was viewed.
  final int views;

  /// Name of review author.
  final String authorName;

  /// Profile image url of the current logged in user.
  final String imageUrl;

  /// Name of product on which the review was posted.
  final String productName;

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

  /// Number of likes given to the review.
  final int likeCount;

  /// Number of comments on the review.
  final int commentCount;

  /// Number of shares to the review
  final int shareCount;

  /// Is the review liked by the current logged in user or not.
  final bool liked;

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
        postedDate: DateTime.now(),
        usedSinceDate: DateTime.now().subtract(Duration(days: 200)),
        views: 100,
        authorName: faker.person.name(),
        imageUrl: StringsManager.picsum200x200,
        productName: 'Oppo Reno 5',
        scores: List.generate(7, (_) => Random().nextInt(5) + 1),
        prosText: StringsManager.lorem,
        consText: StringsManager.lorem,
        likeCount: 100,
        commentCount: 5,
        shareCount: 20,
        liked: Random().nextBool(),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          children: [
            CardHeader(
              postedDate: postedDate,
              usedSinceDate: usedSinceDate,
              views: views,
              authorName: authorName,
              imageUrl: imageUrl,
              productName: productName,
            ),
            10.verticalSpace,
            CardBody(
              scores: scores,
              prosText: prosText,
              consText: consText,
            ),
            10.verticalSpace,
            CardFooter(
              likeCount: likeCount,
              commentCount: commentCount,
              shareCount: shareCount,
              liked: liked,
            ),
          ],
        ),
      ),
    );
  }
}







