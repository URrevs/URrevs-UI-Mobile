import 'dart:math';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

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
        authorName: 'Fady',
        imageUrl: 'https://picsum.photos/200',
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
            _CardHeader(
              postedDate: postedDate,
              usedSinceDate: usedSinceDate,
              views: views,
              authorName: authorName,
              imageUrl: imageUrl,
              productName: productName,
            ),
            10.verticalSpace,
            _RatingBlock(
              scores: scores,
              prosText: prosText,
              consText: consText,
            ),
            10.verticalSpace,
            _Footer(
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

/// Topmost part of the review.
class _CardHeader extends StatelessWidget {
  const _CardHeader({
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

  /// Build the leading part of the header.
  /// Contains the profile photo of the user.
  CircleAvatar _buildLeading() {
    return CircleAvatar(
      radius: 30.sp,
      backgroundColor: ColorManager.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: Image.network(imageUrl),
      ),
    );
  }

  /// Build the line containing the author's name and the product name.
  Row _buildTitle({required BuildContext context}) {
    return Row(
      children: [
        Text(
          authorName,
          style: Theme.of(context).textTheme.headline1,
        ),
        Icon(Icons.arrow_right),
        Text(
          productName,
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }

  /// Builds the line containing dates & views of the review.
  Row _buildSubtitle({required BuildContext context}) {
    // english font is already bigger than arabic font
    // so english font size should be 12 px
    // while arabic font size should be the regular 14 px
    double size =
        context.locale.languageCode == LanguageType.en.name ? 12.sp : 14.sp;
    TextStyle style =
        Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: size);

    final String postedDateStr =
        DateFormat.yMMMMd(context.locale.languageCode).format(postedDate);
    final String usedSinceDateStr =
        DateFormat.yMMMM(context.locale.languageCode).format(usedSinceDate);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(postedDateStr, style: style),
        Padding(
          padding: EdgeInsets.all(1.sp),
          child: Icon(Icons.circle, size: 6.sp),
        ),
        Text(
          LocaleKeys.usedSince.tr() + " " + usedSinceDateStr,
          style: style,
        ),
        Padding(
          padding: EdgeInsets.all(1.sp),
          child: Icon(Icons.circle, size: 6.sp),
        ),
        Icon(Icons.remove_red_eye),
        1.horizontalSpace,
        Text(views.toString(), style: style)
      ],
    );
  }

  /// Builds the trailing part of the header.
  /// It contains a [PopupMenuButton] that shows "I don't like this"
  PopupMenuButton<Object?> _buildTrailing() {
    return PopupMenuButton(
      onSelected: (_) {},
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(child: Text(LocaleKeys.iDontLikeThis.tr())),
      ],
      child: Icon(Icons.more_vert),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _buildLeading(),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(context: context),
                _buildSubtitle(context: context),
              ],
            ),
          ),
          _buildTrailing(),
        ],
      ),
    );
  }
}

/// Middle block of the review card.
/// Contains star ratings and pros and cons of the product.
class _RatingBlock extends StatefulWidget {
  /// Must take an array of scores of 7 items.
  const _RatingBlock({
    Key? key,
    required this.scores,
    required this.prosText,
    required this.consText,
  })  : assert(scores.length == 7),
        super(key: key);

  // defined before in ProductReviewCard
  final List<int> scores;
  final String prosText;
  final String consText;

  @override
  State<_RatingBlock> createState() => _RatingBlockState();
}

class _RatingBlockState extends State<_RatingBlock> {
  bool _expanded = false;

  /// Number of letters show in a review card in the section of pros & cons when
  /// the card is collapsed.
  final int _collapsedMaxLetters = 600;

  /// Number of letters show in a review card in the section of pros & cons when
  /// the card is expanded.
  final int _expandedMaxLetters = 1200;

  /// The max letters limit applied at any moment to the review card.
  /// It is based on the [_expanded] condition of the review card.
  int get maxLetters => _expanded ? _expandedMaxLetters : _collapsedMaxLetters;

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

  /// The cyan circle with the arrow at the middle of the review card indicating
  /// that the card is expandable.
  Card _expandCircle() {
    return Card(
      elevation: 3,
      color: ColorManager.cyan,
      shape: CircleBorder(),
      child: Center(
        child: Icon(
          _expanded
              ? Icons.arrow_drop_up_rounded
              : Icons.arrow_drop_down_rounded,
          size: 40.sp,
          color: ColorManager.white,
        ),
      ),
    );
  }

  /// Rating table which contains 7 rows of star ratings of different aspects
  /// of the product.
  /// The 7 rows are collapsed into 1 row at the collapsed state of the review
  /// card.
  Column _buildRatingTable(BuildContext context) {
    /// Number of star rows shown in review card.
    /// If review card is expanded, all 7 star rows are shown.
    /// If review card is not expanded, only 1 star row is shown.
    int shownStarRows = _expanded ? widget.scores.length : 1;
    return Column(
      children: [
        for (int i = 0; i < shownStarRows; i++) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _ratingCriteria[i].tr() + ":",
                style: Theme.of(context).textTheme.headline2,
              ),
              RatingBar.builder(
                itemSize: 24.sp,
                ignoreGestures: true,
                initialRating: widget.scores[i].toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.sp),
                itemBuilder: (context, _) => Icon(
                  Icons.star_rate_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          ),
        ]
      ],
    );
  }

  /// Cut the pros text according to the [_expanded] state and [maxLetters] of
  /// the review card.
  ///
  /// We would take a substring of the pros text if its length is more than or
  /// equal to the maximum limit of letters specifed by [maxLetters].
  ///
  /// We would return the pros text as it is if its length is less than
  /// [maxLetters]
  String cutPros(String pros) {
    if (pros.length >= maxLetters) {
      String substr = pros.substring(0, maxLetters);
      return substr + "...";
    }
    return pros;
  }

  /// Cut the cons text according to the following rules:
  /// * Define a variable called remainingLetters which is the difference
  /// between the length of pros text and the allowed [maxLetters].
  /// * Return nothing the value of remainingLetters is less than or equal 0 (
  /// it would be less than 0 if pros text length is more than [maxLetters])
  /// * Return the cons text as it is if its length is less than
  /// remainingLetters value.
  /// * Return a substring of cons text if its length is greater than
  /// remainingLetters value.
  String cutCons(String cons) {
    int remainingLetters = maxLetters - widget.prosText.length;
    if (remainingLetters <= 0) {
      return "";
    }
    if (cons.length > remainingLetters) {
      String substr = cons.substring(0, remainingLetters);
      return substr + "...";
    }
    return cons;
  }

  /// Returns a boolean value representing whether we should show cons section
  /// or not.
  bool get showCons => widget.prosText.length < maxLetters;

  /// Returns the block containing the pros and cons text.
  Column _reviewText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.pros.tr(),
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          cutPros(widget.prosText),
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        if (showCons)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              Text(
                LocaleKeys.cons.tr(),
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                cutCons(widget.consText),
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
      ],
    );
  }

  /// Returns a boolean value representing whether the whole pros and cons texts
  /// are shown or substrings of them.
  bool get prosAndConsCut =>
      widget.prosText.length + widget.consText.length > maxLetters;

  /// Decide what would be shown on the [TextButton] shown after pros & cons
  /// section:
  /// * `see more` would be shown if:
  ///   * The card is collapsed.
  ///   * The pros and cons sections are not completely show even after
  ///     expansion.
  /// * `see less` would be shown if the card is expanded and pros and cons
  ///   sections are completely shown.
  String get seeMoreButtonText {
    if (!_expanded) {
      return LocaleKeys.seeMore.tr();
    } else if (!prosAndConsCut) {
      return LocaleKeys.seeLess.tr();
    } else {
      return LocaleKeys.seeMore.tr();
    }
  }

  /// Invoked when user presses on see more button.
  /// * If the review card is collapsed, expand it.
  /// * If the review card is expanded:
  ///   * If the pros and cons text is completely shown, collapse the card.
  ///   * If the pros and cons text is not completely shown, go to fullscreen
  ///     review screen.
  void _seeMoreOnPressed() {
    if (!_expanded) {
      return setState(() => _expanded = true);
    }
    if (!prosAndConsCut) {
      return setState(() => _expanded = false);
    }
    // TODO: go to review full screen
  }

  /// Returns see more button.
  TextButton _seeMoreButton(BuildContext context) {
    /// Adjust the alignment according to the locale.
    final Alignment alignment =
        context.locale.countryCode == LanguageType.en.name
            ? Alignment.centerLeft
            : Alignment.centerRight;

    return TextButton(
      style: TextButton.styleFrom(
        primary: ColorManager.black,
        padding: EdgeInsets.all(0),
        alignment: alignment,
      ),
      onPressed: _seeMoreOnPressed,
      child: Text(seeMoreButtonText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        _expanded = !_expanded;
      }),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRatingTable(context),
            10.verticalSpace,
            _expandCircle(),
            10.verticalSpace,
            _reviewText(context),
            _seeMoreButton(context),
          ],
        ),
      ),
    );
  }
}

/// The bottom part of the review card.
/// Contains counters for likes, comments and shares.
/// Also contains buttons for like, comment and share.
class _Footer extends StatelessWidget {
  const _Footer({
    Key? key,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.liked,
  }) : super(key: key);

  // Defined before
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final bool liked;

  /// Returns a row containing a text and an icon.
  /// This row is fixed at ltr whatever the locale is (arabic or english).
  /// This makes the numbers always on the left side of the icons (which looks
  /// better).
  Row _textAndIcon({required String text, required IconData iconData}) {
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Text(text),
        2.horizontalSpace,
        Icon(iconData),
      ],
    );
  }

  /// Returns a [SizedBox] with the fixed size 100x40.
  ///
  /// Used to wrap like, comment and share [TextButton]s to give them a fixed
  /// size and to resize them using the [ScreenUtil] sizes.
  SizedBox _sizedBox_100x40({required Widget child}) {
    return SizedBox(
      width: 100.w,
      height: 40.h,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              _textAndIcon(
                  text: likeCount.toString(), iconData: Icons.thumb_up),
              Spacer(),
              _textAndIcon(
                text: commentCount.toString(),
                iconData: Icons.comment,
              ),
              7.horizontalSpace,
              _textAndIcon(text: shareCount.toString(), iconData: Icons.share),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _sizedBox_100x40(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.thumb_up),
                  label: Text(LocaleKeys.like.tr()),
                  style: liked
                      ? Theme.of(context).textButtonTheme.style!.copyWith(
                            foregroundColor: MaterialStateProperty.all(
                              ColorManager.blue,
                            ),
                          )
                      : null,
                ),
              ),
              _sizedBox_100x40(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.comment),
                  label: Text(LocaleKeys.comment.tr()),
                ),
              ),
              _sizedBox_100x40(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                  label: Text(LocaleKeys.share.tr()),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
