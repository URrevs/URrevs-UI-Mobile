import 'dart:math';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/styles_manager.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class CommentsTree extends StatelessWidget {
  const CommentsTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Comment.dummyInstance(),
        Padding(
          padding: EdgeInsets.only(
            left: context.isArabic ? 0 : 50.w,
            right: context.isArabic ? 50.w : 0,
          ),
          child: _Comment.dummyInstance(isReply: true),
        ),
      ],
    );
  }
}

class _Comment extends StatelessWidget {
  final String imageUrl;
  final String authorName;
  final String commentText;
  final int likeCount;
  final DateTime datePosted;
  final bool isReply;

  const _Comment({
    Key? key,
    required this.imageUrl,
    required this.authorName,
    required this.commentText,
    required this.likeCount,
    required this.datePosted,
    required this.isReply,
  }) : super(key: key);

  static _Comment dummyInstance({bool isReply = false}) {
    return _Comment(
      imageUrl: StringsManager.picsum200x200,
      authorName: 'Fady Ahmed',
      commentText: 'comment text comment text comment text comment text ',
      likeCount: Random().nextInt(1000000) + 1,
      datePosted: DateTime.now().subtract(
        Duration(hours: Random().nextInt(10000) + 1),
      ),
      isReply: isReply,
    );
  }

  Padding _commentAvatar() {
    double radius = isReply ? 24.r : 32.r;
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: CircleAvatar(
        radius: radius,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.network(imageUrl),
        ),
      ),
    );
  }

  Stack _commentBody(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          color: ColorManager.white,
          child: Container(
            padding: EdgeInsets.only(
              top: 8.h,
              left: 12.w,
              right: 12.w,
              bottom: 16.h,
            ),
            width: isReply ? 143.w : 224.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: _commentText(),
          ),
        ),
        Positioned(
          left: context.isArabic ? -10.w : null,
          right: context.isArabic ? null : -10.w,
          bottom: -8.h,
          child: _likesCounter(context),
        )
      ],
    );
  }

  Column _commentText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          authorName,
          style: TextStyleManager.s14w700,
        ),
        Text(
          commentText,
          style: TextStyleManager.s14w400.copyWith(
            color: ColorManager.grey,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Card _likesCounter(BuildContext context) {
    NumberFormat numberFormat =
        NumberFormat.compact(locale: context.locale.languageCode);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          textDirection: TextDirection.ltr,
          children: [
            Text(numberFormat.format(likeCount)),
            2.horizontalSpace,
            Icon(Icons.thumb_up, color: ColorManager.blue),
          ],
        ),
      ),
    );
  }

  SizedBox _commentFooter(BuildContext context) {
    var textButtonThemeData = TextButtonThemeData(
      style: Theme.of(context).textButtonTheme.style!.copyWith(
            textStyle: MaterialStateProperty.all(
              TextStyleManager.s13w700,
            ),
            foregroundColor: MaterialStateProperty.all(
              ColorManager.black,
            ),
          ),
    );
    return SizedBox(
      width: isReply ? 143.w : 224.w,
      child: TextButtonTheme(
        data: textButtonThemeData,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _sizedBox_50x25(
              child: TextButton(
                onPressed: () {},
                child: Text(LocaleKeys.like.tr()),
              ),
            ),
            _sizedBox_50x25(
              child: TextButton(
                onPressed: () {},
                child: Text(LocaleKeys.reply.tr()),
              ),
            ),
            Text(
              timeago.format(datePosted, locale: context.locale.languageCode),
              style: TextStyleManager.s13w400.copyWith(
                color: ColorManager.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox _sizedBox_50x25({required Widget child}) {
    return SizedBox(
      height: 25.h,
      width: 50.w,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _commentAvatar(),
        6.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _commentBody(context),
            _commentFooter(context),
          ],
        )
      ],
    );
  }
}
