import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
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
  ReviewsFilter filter = ReviewsFilter.phones;
  bool isMobileFilterPressed = true;

  Widget get post => QuestionCard.dummyInstance(context).copyWith(
        cardType: filter == ReviewsFilter.phones
            ? CardType.productQuestion
            : CardType.companyQuestion,
      );

  void _setFilter(ReviewsFilter filter) => setState(() {
        if (isMobileFilterPressed && filter == ReviewsFilter.phones) {
        } else if (!isMobileFilterPressed &&
            filter == ReviewsFilter.companies) {
        } else {
          isMobileFilterPressed = !isMobileFilterPressed;
          this.filter = filter;
        }
      });

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      onPressingFab: () {},
      fabLabel: LocaleKeys.addQuestion.tr(),
      fabIcon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      body: CustomScrollView(
        slivers: [
          AppBars.appBarWithFilters(
              title: LocaleKeys.askedQuestions.tr(),
              setFilter: _setFilter,
              isMobileFilterPressed: isMobileFilterPressed),
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
