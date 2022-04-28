import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/circular_rating_indicator.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/card_body_rating_block.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class ProductRateOverviewCard extends StatelessWidget {
  const ProductRateOverviewCard(
      {Key? key,
      required this.productName,
      required this.generalProductRating,
      required this.generalCompanyRating,
      required this.ratingCriteria,
      required this.scores,
      required this.viewsCounter})
      : super(key: key);

  /// The name of the product.
  final String productName;

  /// The rating criteria.
  final List<String> ratingCriteria;

  /// The general scores of the product.
  final List<int> scores;

  /// The product's views counter.
  final int viewsCounter;

  /// The product's general rating.
  final double generalProductRating;

  /// The product's company general rating.
  final double generalCompanyRating;
  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat =
        NumberFormat.compact(locale: context.locale.languageCode);
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.postCardRadius),
      ),
      color: ColorManager.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Spacer(),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          productName,
                          style: TextStyleManager.s18w700,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(LocaleKeys.smartphone.tr(),
                            style: TextStyleManager.s14w400),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Icon(IconsManager.views, size: 20.sp),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          numberFormat.format(viewsCounter),
                          style: TextStyleManager.s14w400,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
              decoration: ShapeDecoration(
                color: ColorManager.blue.withOpacity(0.35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        IconsManager.addToOwnedProducts,
                        size: AppSize.s28,
                        color: ColorManager.black,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        LocaleKeys.setAsOwnedPhone.tr(),
                        style: TextStyleManager.s14w400
                            .copyWith(color: ColorManager.black),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// The product's general rating circular indicator.
                  CircularRatingIndicator(
                      ratingTitle: LocaleKeys.generalProductRating.tr(),
                      rating: generalProductRating),
                  /// The product's company general rating circular indicator.
                  CircularRatingIndicator(
                      ratingTitle: LocaleKeys.generalCompanyRating.tr(),
                      rating: generalCompanyRating),
                ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: CardBodyRatingBlock(
              expanded: true,
              fullscreen: true,
              ratingCriteria: ratingCriteria,
              scores: scores,
            ),
          )
        ],
      ),
    );
  }
}
