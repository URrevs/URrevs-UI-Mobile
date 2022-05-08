import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class PostedQuestionsScreen extends StatefulWidget {
  const PostedQuestionsScreen({Key? key}) : super(key: key);

  static const String routeName = 'PostedQuestionsScreen';

  @override
  State<PostedQuestionsScreen> createState() => _PostedQuestionsScreenState();
}

class _PostedQuestionsScreenState extends State<PostedQuestionsScreen> {
  ReviewsFilter _filter = ReviewsFilter.phones;
  bool isMobileFilterPressed = true;

  Widget get post => QuestionCard.dummyInstance(context).copyWith(
        cardType: _filter == ReviewsFilter.phones
            ? CardType.productQuestion
            : CardType.companyQuestion,
      );

  void _setFilter(ReviewsFilter filter) => setState(() {
        if (isMobileFilterPressed && filter == ReviewsFilter.phones) {
        } else if (!isMobileFilterPressed &&
            filter == ReviewsFilter.companies) {
        } else {
          isMobileFilterPressed = !isMobileFilterPressed;
          this._filter = filter;
        }
      });

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      appBar: AppBars.appBarWithTitle(
        context: context,
        title: LocaleKeys.postedQuestions.tr(),
        elevation: 1,
      ),
      onPressingFab: () {},
      fabLabel: LocaleKeys.addQuestion.tr(),
      fabIcon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      body: CustomScrollView(
        slivers: [
          _buildFilterBar(),
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

  Widget _buildFilterBar() {
    return SliverAppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: ColorManager.white,
      iconTheme: IconThemeData(
        color: ColorManager.black,
      ),
      elevation: 3,
      forceElevated: true,
      snap: true,
      floating: true,
      toolbarHeight: 45.h,
      collapsedHeight: 45.h,
      expandedHeight: 45.h,
      flexibleSpace: Row(
        children: [
          SizedBox(width: 17.w),
          TextButton(
            style: ButtonStyle(
              backgroundColor: _filter == ReviewsFilter.phones
                  ? MaterialStateProperty.all<Color>(ColorManager.buttonGrey)
                  : MaterialStateProperty.all<Color>(ColorManager.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                  side: BorderSide(color: ColorManager.buttonGrey),
                ),
              ),
            ),
            onPressed: () => _setFilter(ReviewsFilter.phones),
            child: Text(
              LocaleKeys.phones.tr(),
              style: TextStyleManager.s14w700.copyWith(
                color: _filter == ReviewsFilter.phones
                    ? ColorManager.white
                    : ColorManager.buttonGrey,
              ),
            ),
          ),
          SizedBox(width: 17.w),
          TextButton(
            style: ButtonStyle(
              backgroundColor: _filter == ReviewsFilter.companies
                  ? MaterialStateProperty.all<Color>(ColorManager.buttonGrey)
                  : MaterialStateProperty.all<Color>(ColorManager.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                  side: BorderSide(color: ColorManager.buttonGrey),
                ),
              ),
            ),
            onPressed: () => _setFilter(ReviewsFilter.companies),
            child: Text(
              LocaleKeys.companies.tr(),
              style: TextStyleManager.s14w700.copyWith(
                color: _filter == ReviewsFilter.companies
                    ? ColorManager.white
                    : ColorManager.buttonGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
