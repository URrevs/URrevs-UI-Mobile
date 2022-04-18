import 'dart:math';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_footer.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/card_header.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// A card showing a review for a product.
class CompanyReviewCard extends StatelessWidget {
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
  final String companyName;

  /// An integer from 1 to 5 representing the company general rating
  final int generalRating;

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

  /// The single rating criteria shown in a company review card.
  final List<String> _ratingCriteria = const [LocaleKeys.companyRating];

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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          children: [
            CardHeader(
              imageUrl: imageUrl,
              authorName: authorName,
              productName: companyName,
              postedDate: postedDate,
              usedSinceDate: usedSinceDate,
              views: views,
              showUsedSincePart: false,
            ),
            10.verticalSpace,
            CardBody(
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
            ),
          ],
        ),
      ),
    );
  }
}
