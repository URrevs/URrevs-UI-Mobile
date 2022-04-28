import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/presentation_models/posting_review_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class PostedReviewsScreen extends StatefulWidget {
  const PostedReviewsScreen({Key? key}) : super(key: key);

  static const String routeName = 'PostedReviewsScreen';

  @override
  State<PostedReviewsScreen> createState() => _PostedReviewsScreenState();
}

class _PostedReviewsScreenState extends State<PostedReviewsScreen> {
  ReviewsFilter filter = ReviewsFilter.phones;

  Widget get post => filter == ReviewsFilter.phones
      ? ProductReviewCard.dummyInstance()
      : CompanyReviewCard.dummyInstance();

  void _setFilter(ReviewsFilter filter) => setState(() => this.filter = filter);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      onPressingFab: () {},
      fabLabel: LocaleKeys.addReview.tr(),
      fabIcon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      body: CustomScrollView(
        slivers: [
          AppBars.appBarWithFilters(setFilter: _setFilter),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    post,
                    10.verticalSpace,
                  ],
                ),
                childCount: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
