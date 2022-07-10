import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/posting_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/verify_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/circular_rating_indicator.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/card_body_rating_block.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// A card showing a rating overview for a product or a company according to the flag [isProduct].
class RatingOverviewCard extends ConsumerWidget {
  const RatingOverviewCard({
    Key? key,
    this.productId,
    required this.productName,
    this.owned,
    this.generalProductRating,
    required this.generalCompanyRating,
    this.scores,
    required this.viewsCounter,
    required this.isProduct,
    required this.verificationRatio,
  })  : assert(
          !(isProduct && generalProductRating == null),
          'if the card represents a product, a general product rating should be provided',
        ),
        assert(!(isProduct && verificationRatio == null)),
        super(key: key);

  /// The id of the product.
  /// can be null when phone specs is not loaded
  final String? productId;

  /// The name of the product.
  final String productName;

  final bool? owned;

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
  final double? verificationRatio;

  /// The rating criteria.
  final List<String> _ratingCriteria = const [
    LocaleKeys.userInterface,
    LocaleKeys.manufacturingQuality,
    LocaleKeys.priceQuality,
    LocaleKeys.camera,
    LocaleKeys.callsQuality,
    LocaleKeys.battery,
  ];

  bool get buttonDisabled =>
      productId == null || (owned == true && verificationRatio != 0);

  String get buttonText {
    if (owned != true) {
      return LocaleKeys.setAsOwnedPhone.tr();
    } else if (verificationRatio == 0) {
      return LocaleKeys.verifyPhone.tr();
    } else {
      return LocaleKeys.ownedPhone.tr();
    }
  }

  IconData get buttonIcon {
    if (owned != true) {
      return IconsManager.addToOwnedProducts;
    } else {
      return Icons.check;
    }
  }

  VoidCallback? onPressingButton(
      BuildContext context, WidgetRef ref, VerifyProviderParams? params) {
    if (productId == null) return null;
    if (owned != true) {
      return () {
        Navigator.of(context).pushNamed(
          PostingScreen.routeName,
          arguments: PostingScreenArgs(
            postContentType: PostContentType.review,
            phone: Phone(
              id: productId!,
              name: productName,
            ),
          ),
        );
      };
    } else if (verificationRatio == 0) {
      return () {
        // params would not be null if productId is not null
        ref.read(verifyProvider(params!).notifier).verifyPhone();
      };
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    VerifyProviderParams? params;
    if (productId != null) {
      params = VerifyProviderParams(
        phoneId: productId!,
        userId: ref.currentUser!.id,
      );
      ref.listen(verifyProvider(params), (previous, next) {
        if (next is VerifyLoadedState &&
            next.verificationRatio == 0 &&
            ModalRoute.of(context)!.isCurrent) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(LocaleKeys
                  .youMustOpenTheApplicationFromTheDeviceYouWantToVerifyYourReviewOnIt
                  .tr()),
              duration: Duration(seconds: 6),
            ),
          );
        }
      });
    }

    NumberFormat numberFormat =
        NumberFormat.compact(locale: context.locale.languageCode);
    return Card(
      elevation: AppElevations.ev3,
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
                      color: buttonDisabled
                          ? ColorManager.grey.withOpacity(0.35)
                          : ColorManager.blue.withOpacity(0.35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: TextButton(
                          onPressed: onPressingButton(context, ref, params),
                          child: Row(
                            children: [
                              Icon(
                                buttonIcon,
                                size: AppSize.s28,
                                color: buttonDisabled
                                    ? ColorManager.black.withOpacity(0.6)
                                    : ColorManager.black,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                buttonText,
                                style: TextStyleManager.s14w400.copyWith(
                                    color: buttonDisabled
                                        ? ColorManager.black.withOpacity(0.6)
                                        : ColorManager.black),
                              ),
                            ],
                          )),
                    ),
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
                    ratingCriteria: _ratingCriteria,
                    scores: scores!,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
