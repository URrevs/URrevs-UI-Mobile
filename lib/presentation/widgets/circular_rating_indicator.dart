
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class CircularRatingIndicator extends StatefulWidget {
  const CircularRatingIndicator({
    required this.ratingTitle,
    required this.rating,
    Key? key,
  }) : super(key: key);

  /// The title of the rating indicator.
  final String ratingTitle;

  /// The rating of the indicator.
  final double rating;

  @override
  State<CircularRatingIndicator> createState() => _CircularRatingIndicatorState();
}

class _CircularRatingIndicatorState extends State<CircularRatingIndicator> {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
        restartAnimation: true,
        animationDuration: 2,
        circularStrokeCap: CircularStrokeCap.square,
        animateFromLastPercent: true,
        center: RichText(
            text: TextSpan(
          style: TextStyleManager.s24w500
              .copyWith(color: ColorManager.black),
          children: [
            TextSpan(text: widget.rating.toStringAsFixed(1)),
            TextSpan(
                text: '/5',
                style: TextStyleManager.s20w400),
          ],
        )),
        animation: true,
        progressColor: ColorManager.blue,
        percent: widget.rating / 5,
        footer: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            widget.ratingTitle,
            style: TextStyleManager.s14w500,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
          ),
        ),
        radius: 40.r);
  }
}
