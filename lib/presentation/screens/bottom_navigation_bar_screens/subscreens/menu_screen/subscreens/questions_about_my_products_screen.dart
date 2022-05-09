import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class QuestionsAboutMyProductsScreen extends StatefulWidget {
  const QuestionsAboutMyProductsScreen({Key? key}) : super(key: key);

  static const String routeName = 'QuestionsAboutMyProductsScreen';

  @override
  State<QuestionsAboutMyProductsScreen> createState() =>
      _QuestionsAboutMyProductsScreenState();
}

class _QuestionsAboutMyProductsScreenState
    extends State<QuestionsAboutMyProductsScreen> {
  Widget get post => QuestionCard.dummyInstance(context);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      appBar: AppBars.appBarWithTitle(
        context: context,
        title: LocaleKeys.questionsOnMyProducts.tr(),
        elevation: 1,
      ),
      onPressingFab: () {},
      hideFab: true,
      fabLabel: LocaleKeys.addQuestion.tr(),
      fabIcon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      body: CustomScrollView(
        slivers: [
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
