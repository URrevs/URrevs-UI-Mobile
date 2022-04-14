import 'dart:math';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
  }) : super(key: key);

  String get lorem =>
      'Dolor voluptate amet est adipisicing ullamco sit eiusmod consequat sunt labore aliquip id. Aliquip nulla consequat ullamco ullamco ad laborum. Tempor aliquip veniam culpa cillum consequat cillum. Officia laborum est qui do consequat eu anim nostrud consequat voluptate nostrud culpa do. Voluptate fugiat magna qui. Anim dolore laborum pariatur amet adipisicing magna. Velit deserunt qui voluptate veniam deserunt exercitation do quis ea nulla velit nulla nisi. Laborum veniam consequat elit aliqua mollit commodo incididunt esse fugiat minim deserunt.';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          children: [
            _CardHeader(
              postedDate: DateTime.now(),
              usedSinceDate: DateTime.now().subtract(Duration(days: 200)),
              views: 100,
              authorName: 'Fady',
              productName: 'Oppo Reno 5',
            ),
            10.verticalSpace,
            _RatingBlock(
              scores: List.generate(7, (_) => Random().nextInt(5) + 1),
              prosText: lorem,
              consText: lorem,
            ),
            10.verticalSpace,
            _Footer(likeCount: 100, commentCount: 5, shareCount: 20),
          ],
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({
    Key? key,
    required this.postedDate,
    required this.usedSinceDate,
    required this.views,
    required this.authorName,
    required this.productName,
  }) : super(key: key);

  final DateTime postedDate;
  final DateTime usedSinceDate;
  final int views;
  final String authorName;
  final String productName;

  PopupMenuButton<Object?> _buildTrailing() {
    return PopupMenuButton(
      child: Icon(Icons.more_vert),
      itemBuilder: (context) => [],
    );
  }

  // at screen width = 500px, text size should be reduced to 12px
  Row _buildSubtitle({
    required BuildContext context,
    required String postedDateStr,
    required String usedSinceDateStr,
    required int views,
  }) {
    // english font is already bigger than arabic font
    double size =
        context.locale.languageCode == LanguageType.en.name ? 12.sp : 14.sp;
    TextStyle style =
        Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: size);
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

  Row _buildTitle({
    required BuildContext context,
    required String authorName,
    required String productName,
  }) {
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

  @override
  Widget build(BuildContext context) {
    final String postedDateStr =
        DateFormat.yMMMMd(context.locale.languageCode).format(postedDate);
    final String usedSinceDateStr =
        DateFormat.yMMMM(context.locale.languageCode).format(usedSinceDate);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.sp,
            child: FlutterLogo(size: 16.sp),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(
                  context: context,
                  authorName: authorName,
                  productName: productName,
                ),
                _buildSubtitle(
                  context: context,
                  postedDateStr: postedDateStr,
                  usedSinceDateStr: usedSinceDateStr,
                  views: views,
                ),
              ],
            ),
          ),
          _buildTrailing(),
        ],
      ),
    );
  }
}

class _RatingBlock extends StatefulWidget {
  const _RatingBlock({
    Key? key,
    required this.scores,
    required this.prosText,
    required this.consText,
  })  : assert(scores.length == 7),
        super(key: key);

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
  int get _collapsedMaxLetters => 500;

  /// Number of letters show in a review card in the section of pros & cons when
  /// the card is expanded.
  int get _expandedMaxLetters => 1200;

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

  Table _buildRatingTable(BuildContext context) {
    /// Number of star rows shown in review card.
    /// If review card is expanded, all 7 star rows are shown.
    /// If review card is not expanded, only 1 star row is shown.
    int shownStarRows = _expanded ? widget.scores.length : 1;
    return Table(
      children: [
        for (int i = 0; i < shownStarRows; i++) ...[
          TableRow(
            children: [
              Text(
                _ratingCriteria[i].tr() + ":",
                style: Theme.of(context).textTheme.headline2,
              ),
              RatingBar.builder(
                itemSize: 18.sp,
                ignoreGestures: true,
                initialRating: widget.scores[i].toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.sp),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
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

  String cutPros(String pros) {
    if (pros.length > maxLetters) {
      String substr = pros.substring(0, maxLetters);
      return substr + "...";
    }
    return pros;
  }

  String cutCons(String cons) {
    int remainingLetters = maxLetters - widget.prosText.length;
    if (remainingLetters < 0) {
      return "";
    } else if (remainingLetters == 0) {
      return "...";
    }
    if (cons.length > remainingLetters) {
      String substr = cons.substring(0, remainingLetters);
      return substr + "...";
    }
    return cons;
  }

  bool get showCons => widget.prosText.length <= maxLetters;

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

  TextButton _seeMoreButton(BuildContext context) {
    final Alignment alignment =
        context.locale.countryCode == LanguageType.en.name
            ? Alignment.centerLeft
            : Alignment.centerRight;
    final String text = seeMoreButtonText;

    return TextButton(
      style: TextButton.styleFrom(
        primary: ColorManager.black,
        padding: EdgeInsets.all(0),
        alignment: alignment,
      ),
      onPressed: () {
        if (!_expanded) {
          return setState(() => _expanded = true);
        }
        if (!prosAndConsCut) {
          return setState(() => _expanded = false);
        }
        // TODO: go to review full screen
      },
      child: Text(text),
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

class _Footer extends StatelessWidget {
  const _Footer({
    Key? key,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
  }) : super(key: key);

  final int likeCount;
  final int commentCount;
  final int shareCount;

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
