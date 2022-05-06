import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/rating_overview_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/disclaimer_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/specs_table.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/custom_network_image.dart';
import 'dart:math' as math;

class SuggestedItem {
  final String name;
  final String imageUrl;

  SuggestedItem({
    required this.name,
    required this.imageUrl,
  });
}

/// Testing data for similar phones widget.
List<SuggestedItem> suggestedItems = [
  SuggestedItem(
      name: 'Samsung Galaxy A52s',
      imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  SuggestedItem(
      name: 'Samsung Galaxy A32',
      imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  SuggestedItem(
      name: 'Samsung Galaxy A72',
      imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  SuggestedItem(
      name: 'Samsung Galaxy A72sdfsd gasdfgadfgas',
      imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  SuggestedItem(
      name: 'Samsung Galaxy A72',
      imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
];

class ProductProfileSpecsSubscreen extends StatefulWidget {
  const ProductProfileSpecsSubscreen({Key? key}) : super(key: key);

  @override
  State<ProductProfileSpecsSubscreen> createState() =>
      _ProductProfileSpecsSubscreenState();
}

class _ProductProfileSpecsSubscreenState
    extends State<ProductProfileSpecsSubscreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 12.h, bottom: 70.h),
      addAutomaticKeepAlives: false,
      cacheExtent: 100,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
          child: RatingOverviewCard(
              productName: 'Nokia 7 Plus',
              generalProductRating: 4.5,
              generalCompanyRating: 3,
              scores: [4, 3, 4, 4, 4, 2],
              viewsCounter: 100,
              isProduct: true),
        ),
        Text(LocaleKeys.productImage.tr() + ':',
            style: TextStyleManager.s18w700),
        Card(
          elevation: AppElevations.ev3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.postCardRadius),
          ),
          color: ColorManager.white,
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: CustomNetworkImage(
                    imageUrl: 'https://picsum.photos/200/300'),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Text(LocaleKeys.specifications.tr() + ':',
                style: TextStyleManager.s18w700),
            IconButton(
              padding: EdgeInsets.zero,
              icon: context.isArabic
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Icon(
                        IconsManager.help,
                        size: 30.sp,
                      ),
                    )
                  : Icon(
                      IconsManager.help,
                      size: 30.sp,
                    ),
              color: ColorManager.blue,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DisclaimerDialog();
                  },
                );
              },
            )
          ],
        ),
        // SpecsTable.dummyInstance,
        SizedBox(height: 12.h),
        Text(
          LocaleKeys.similarPhones.tr() + ':',
          style: TextStyleManager.s18w700,
        ),
        Card(
          elevation: AppElevations.ev3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.postCardRadius),
          ),
          color: ColorManager.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.postCardRadius),
            child: Container(
              color: ColorManager.white,
              height: 210.h,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: Center(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: suggestedItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 20.0, left: 8, right: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProductProfileScreen.routeName,
                            );
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                width: 85.w,
                                height: 110.h,
                                child: CustomNetworkImage(
                                    imageUrl: suggestedItems[index].imageUrl),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: SizedBox(
                                  width: 100.w,
                                  height: 60.h,
                                  child: Flexible(
                                    child: Text(
                                      suggestedItems[index].name,
                                      style: TextStyleManager.s16w500,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
