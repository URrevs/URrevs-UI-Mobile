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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 16.w,
        ),
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
    return Row(
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
    );
  }
}

class _RatingBlock extends StatelessWidget {
  const _RatingBlock({
    Key? key,
    required this.scores,
  })  : assert(scores.length == 7),
        super(key: key);

  final List<int> scores;

  final List<String> ratingCriteria = const [
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
          Icons.arrow_drop_up_rounded,
          size: 40.sp,
          color: ColorManager.white,
        ),
      ),
    );
  }

  Table _buildRatingTable(BuildContext context) {
    return Table(
      children: [
        for (int i = 0; i < scores.length; i++) ...[
          TableRow(
            children: [
              Text(
                ratingCriteria[i].tr() + ":",
                style: Theme.of(context).textTheme.headline2,
              ),
              RatingBar.builder(
                itemSize: 18.sp,
                ignoreGestures: true,
                initialRating: scores[i].toDouble(),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRatingTable(context),
        10.verticalSpace,
        _expandCircle(),
        10.verticalSpace,
        Text(
          LocaleKeys.pros.tr(),
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          'Magna deserunt velit magna. Enim dolore ut sint. Officia id cillum amet incididunt dolor consequat sit. Occaecat adipisicing aliquip labore incididunt ex elit anim officia Lorem ea fugiat amet voluptate velit. Consectetur aliqua sunt incididunt et aute. Dolore enim magna sit irure aute excepteur laboris culpa velit cupidatat velit.',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        10.verticalSpace,
        Text(
          LocaleKeys.cons.tr(),
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          'Magna deserunt velit magna. Enim dolore ut sint. Officia id cillum amet incididunt dolor consequat sit. Occaecat adipisicing aliquip labore incididunt ex elit anim officia Lorem ea fugiat amet voluptate velit. Consectetur aliqua sunt incididunt et aute. Dolore enim magna sit irure aute excepteur laboris culpa velit cupidatat velit.',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        TextButton(
          style: TextButton.styleFrom(
            primary: ColorManager.black,
            padding: EdgeInsets.all(0),
            alignment: context.locale.countryCode == LanguageType.en.name
                ? Alignment.centerLeft
                : Alignment.centerRight,
          ),
          onPressed: () {},
          child: Text(LocaleKeys.seeMore.tr()),
        ),
      ],
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
        Row(
          children: [
            _textAndIcon(text: likeCount.toString(), iconData: Icons.thumb_up),
            Spacer(),
            _textAndIcon(
              text: commentCount.toString(),
              iconData: Icons.comment,
            ),
            7.horizontalSpace,
            _textAndIcon(text: shareCount.toString(), iconData: Icons.share),
          ],
        ),
        Divider(),
        Row(
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
        )
      ],
    );
  }
}
