import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/circular_rating_indicator.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/card_body_rating_block.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// A card showing a rating overview for a product or a company according to the flag [isProduct].
class RatingOverviewCard extends StatelessWidget {
  const RatingOverviewCard({
    Key? key,
    required this.productName,
    this.generalProductRating,
    required this.generalCompanyRating,
    this.ratingCriteria,
    this.scores,
    required this.viewsCounter,
    required this.isProduct,
  })  : assert(
          !(isProduct && generalProductRating != null),
          'if the card represents a product, a general product rating should be provided',
        ),
        super(key: key);

  /// The name of the product.
  final String productName;

  /// The rating criteria.
  final List<String>? ratingCriteria;

  /// The general scores of the product.
  final List<int>? scores;

  /// The product's views counter.
  final int viewsCounter;

  /// The product's general rating.
  final double? generalProductRating;

  /// The product's company general rating.
  final double generalCompanyRating;

  /// Flag to determine if the card is in the product profile screen.
  final bool isProduct;
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
            padding: EdgeInsets.all(10.sp),
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
                        Text(
                            isProduct
                                ? LocaleKeys.smartphone.tr()
                                : LocaleKeys.company.tr(),
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
          isProduct
              ? FittedBox(
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
                )
              : Container(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: Row(
                mainAxisAlignment: isProduct
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  /// The product's general rating circular indicator.
                  isProduct
                      ? CircularRatingIndicator(
                          ratingTitle: LocaleKeys.generalProductRating.tr(),
                          rating: generalProductRating!)
                      : Container(),

                  /// The product's company general rating circular indicator.
                  CircularRatingIndicator(
                      ratingTitle: LocaleKeys.generalCompanyRating.tr(),
                      rating: generalCompanyRating),
                ]),
          ),
          isProduct
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  child: CardBodyRatingBlock(
                    expanded: true,
                    fullscreen: true,
                    ratingCriteria: ratingCriteria!,
                    scores: scores!,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
