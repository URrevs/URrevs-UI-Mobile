import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/review_card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// A card showing a review for a product.
class ProductReviewCard extends ConsumerWidget {
  /// Profile image url of the current logged in user.
  final String? imageUrl;

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

  final bool fullscreen;

  final VoidCallback onPressingComment;

  final String reviewId;

  final String userId;

  final String productId;

  ProductReviewCard({
    Key? key,
    required this.reviewId,
    required this.userId,
    required this.productId,
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
    required this.fullscreen,
    required this.onPressingComment,
  })  : _postProviderParams = PostProviderParams(
          postId: 'dummy',
          postType: PostType.phoneReview,
          post: PhoneReview.dummyInstance,
        ),
        super(key: key);

  ProductReviewCard.fromPhoneReview({
    required PhoneReview phoneReview,
    required this.fullscreen,
    required this.onPressingComment,
    Key? key,
  })  : reviewId = phoneReview.id,
        userId = phoneReview.userId,
        productId = phoneReview.targetId,
        postedDate = phoneReview.createdAt,
        usedSinceDate = phoneReview.ownedAt,
        views = phoneReview.views,
        authorName = phoneReview.userName,
        imageUrl = phoneReview.photo,
        productName = phoneReview.targetName,
        scores = phoneReview.scores,
        prosText = phoneReview.pros,
        consText = phoneReview.cons,
        likeCount = phoneReview.likes,
        commentCount = phoneReview.commentsCount,
        shareCount = phoneReview.shares,
        liked = phoneReview.liked,
        _postProviderParams = PostProviderParams(
          postId: phoneReview.id,
          postType: PostType.phoneReview,
          post: phoneReview,
        ),
        super(key: key);

  /// An instance of [ProductReviewCard] filled with dummy data.
  static ProductReviewCard dummyInstance({bool fullscreen = false}) =>
      ProductReviewCard(
        reviewId: 'dummyReviewId-${DateTime.now().microsecondsSinceEpoch}',
        userId: 'userId-${DateTime.now().microsecondsSinceEpoch}',
        productId: 'productId-${DateTime.now().microsecondsSinceEpoch}',
        postedDate: faker.date.dateTime(minYear: 2000, maxYear: 2022),
        usedSinceDate: faker.date.dateTime(minYear: 2000, maxYear: 2021),
        views: DummyDataManager.randomInt,
        authorName: faker.person.name(),
        imageUrl: StringsManager.picsum200x200,
        productName: 'Oppo Reno 5',
        scores: List.generate(7, (_) => Random().nextInt(5) + 1),
        prosText: StringsManager.longestReviewPros,
        consText: StringsManager.longestReviewCons,
        likeCount: DummyDataManager.randomInt,
        commentCount: DummyDataManager.randomInt,
        shareCount: DummyDataManager.randomInt,
        liked: Random().nextBool(),
        fullscreen: fullscreen,
        onPressingComment: () {},
      );

  ProductReviewCard copyWith({
    String? reviewId,
    String? userId,
    String? productId,
    String? imageUrl,
    String? authorName,
    String? productName,
    DateTime? postedDate,
    DateTime? usedSinceDate,
    int? views,
    List<int>? scores,
    String? prosText,
    String? consText,
    bool? liked,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    bool? fullscreen,
    VoidCallback? onPressingComment,
  }) {
    return ProductReviewCard(
      reviewId: reviewId ?? this.reviewId,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      postedDate: postedDate ?? this.postedDate,
      usedSinceDate: usedSinceDate ?? this.usedSinceDate,
      views: views ?? this.views,
      authorName: authorName ?? this.authorName,
      imageUrl: imageUrl ?? this.imageUrl,
      productName: productName ?? this.productName,
      scores: scores ?? this.scores,
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
        message: LocaleKeys.productReview.tr(),
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

  late final PostProviderParams _postProviderParams;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PhoneReview review =
        ref.watch(postProvider(_postProviderParams)) as PhoneReview;
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
                  targetName: productName,
                  postedDate: postedDate,
                  usedSinceDate: usedSinceDate,
                  views: views,
                  cardType: CardType.productReview,
                  userId: userId,
                  targetId: productId,
                  type: TargetType.phone,
                ),
                10.verticalSpace,
                ReviewCardBody(
                  ratingCriteria: _ratingCriteria,
                  scores: scores,
                  prosText: prosText,
                  consText: consText,
                  showExpandCircle: true,
                  hideSeeMoreIfNoNeedForExpansion: false,
                  cardType: CardType.productReview,
                  fullscreen: fullscreen,
                ),
                8.verticalSpace,
                CardFooter(
                  userId: userId,
                  postId: reviewId,
                  postType: PostType.phoneReview,
                  likeCount: review.likes,
                  commentCount: review.commentsCount,
                  shareCount: review.shares,
                  liked: liked,
                  useInReviewCard: true,
                  onLike: _onLike,
                  onComment: onPressingComment,
                  onShare: _onShare,
                  cardType: CardType.productReview,
                  fullscreen: fullscreen,
                ),
              ],
            ),
          ),
        ),
        _buildQuestionMark(context),
      ],
    );
  }
}
