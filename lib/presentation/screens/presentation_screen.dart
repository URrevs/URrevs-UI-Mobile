import 'dart:math';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:faker/faker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/alert_dialog_title.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/bottom_navigation_bar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/auth_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/competition_banner.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/rating_overview_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/circular_rating_indicator.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/datepicker_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/txt_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answer_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answers_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comment_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comments_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/reply.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/adding_competition_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/disclaimer_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/how_to_win_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/marked_as_accepted_explanation_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/prize_photo_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/referral_code_help_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/review_encouragement_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/card_body_rating_block.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/see_more_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/review_card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/specs_comparison_table.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/specs_table.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/stars_counter.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/company_horizontal_list_tile.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/company_logo_tile.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/leaderboard_entry_tile.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/updated_list_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PresentationScreen extends ConsumerStatefulWidget {
  const PresentationScreen({Key? key}) : super(key: key);

  static const String routeName = 'PresentationScreen';

  @override
  ConsumerState<PresentationScreen> createState() => _PresentationScreenState();
}

List<Item> items = [
  Item(itemName: 'Xiaomi Redmi Note 6', type: ItemDescription.smartphone),
  Item(itemName: 'Xiaomi', type: ItemDescription.company),
];

class _PresentationScreenState extends ConsumerState<PresentationScreen> {
  bool isSelected = false;
  int selectedIndex = -1;
  TextEditingController dateCtl = TextEditingController();
  TextEditingController textCtl = TextEditingController();
  TextEditingController winnerNumCtl = TextEditingController();
  TextEditingController prizeNameCtl = TextEditingController();
  TextEditingController imgUrlCtl = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat =
        NumberFormat.compact(locale: context.locale.languageCode);
    String competitionDate = 'أدخل تاريخ انتهاء المسابقة';
    String hintText = 'عدد الفائزين';

    return Scaffold(
      //appBar: AppBars.appBarWithActions(context: context, imageUrl: StringsManager.picsum200x200),
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => context.setLocale(LanguageType.ar.locale),
            child: Text('ar'),
          ),
          ElevatedButton(
            onPressed: () => context.setLocale(LanguageType.en.locale),
            child: Text('en'),
          ),
          ElevatedButton(
            onPressed: () => ref
                .read(themeModeProvider.notifier)
                .setThemeMode(ThemeMode.dark),
            child: Text('🌙'),
          ),
          ElevatedButton(
            onPressed: () => ref
                .read(themeModeProvider.notifier)
                .setThemeMode(ThemeMode.light),
            child: Text('☀'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     print("scale width: ${ScreenUtil().scaleWidth}");
          //     print("scale height: ${ScreenUtil().scaleHeight}");
          //     print("screen width: ${ScreenUtil().screenWidth}");
          //     print("ui size: ${ScreenUtil().uiSize}");
          //   },
          //   child: Text('screen util'),
          // ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(height: 20),
          HowToWinDialog(),
          SizedBox(height: 20),
          MarkedAsAcceptedExplanationDialog(),
          SizedBox(height: 20),
          ReferralCodeHelpDialog(),
          SizedBox(height: 20),
          DisclaimerDialog(),
          SizedBox(height: 20),
          ReviewEncouragementDialog(),
          SizedBox(height: 20),
          PrizePhotoDialog(
            prizeName: 'Xiaomi Mi Band 5',
            imageUrl:
                'https://shop.btcegyptgold.com/media/catalog/product/cache/54154f8e5f8cfdda3a2d411d19afaba5/1/k/1kg_995.5.jpg',
          ),
          SizedBox(height: 20),
          AddingCompetitionPrompt(
              dateController: dateCtl,
              numberOfWinnersController: winnerNumCtl,
              prizeNameController: prizeNameCtl,
              imgUrlController: imgUrlCtl),

          //TxtField(textCtl: textCtl, hintText: hintText),
          SizedBox(
            height: 20,
          ),
          //DatePickerField(dateCtl: dateCtl, hintText: competitionDate),
          SizedBox(height: 20),
          LeaderboardEntryTile(
            name: 'Ziad Mostafa',
            imageUrl: 'https://picsum.photos/seed/picsum/200/200',
            rank: 544,
            starsCounter: 40002344,
          ),
          SizedBox(height: 20),
          StarsCounter(percentage: 0.5),
          SizedBox(height: 20),
          RatingOverviewCard(
            productName: 'Nokia 7 Plus',
            scores: DummyDataManager.productOverviewScores,
            generalProductRating:
                DummyDataManager.randomCircularIndicatorDouble,
            generalCompanyRating:
                DummyDataManager.randomCircularIndicatorDouble,
            viewsCounter: DummyDataManager.randomInt,
            isProduct: true,
          ),
          AuthButton(
              text: LocaleKeys.googleAuth.tr(),
              imagePath: SvgAssets.googleLogo,
              color: ColorManager.grey,
              onPressed: () {}),
          SizedBox(height: 20),
          AuthButton(
              text: LocaleKeys.facebookAuth.tr(),
              imagePath: SvgAssets.facebookLogo,
              color: ColorManager.blue,
              onPressed: () {}),
          SizedBox(height: 20),
          CompetitionBanner(
            numberOfRemainingdays: 12,
            prizeName: 'Xiaomi Mi Band 5',
          ),
          SizedBox(
            height: 20,
          ),
          GradButton(
            text: Text(
              LocaleKeys.shareInvitationLink.tr(),
              style: TextStyleManager.s18w700,
            ),
            icon: Icon(
              IconsManager.share,
              size: 23.sp,
            ),
            width: 325.w,
            reverseIcon: false,
            onPressed: () {},
          ),
          SizedBox(height: 20),
          CompanyHorizontalListTile(companyItems: companyItems),
          SizedBox(height: 20),

          SizedBox(height: 20),
          RatingOverviewCard(
            productName: 'Nokia',
            scores: DummyDataManager.productOverviewScores,
            generalProductRating:
                DummyDataManager.randomCircularIndicatorDouble,
            generalCompanyRating:
                DummyDataManager.randomCircularIndicatorDouble,
            viewsCounter: DummyDataManager.randomInt,
            isProduct: false,
          ),
          SizedBox(height: 20),
          UpdatedListTile(
            title: 'قائمة المنتجات المضافة حديثاً',
            items: items,
          ),
          SizedBox(height: 20),
          UpdatedListTile(title: 'قائمة الشركات المضافة حديثاً', items: items),
          ProductReviewCard.dummyInstance(),
          CompanyReviewCard.dummyInstance(),
          QuestionCard.dummyInstance(context),
          CommentTree.dummyInstance,
          AnswerTree.dummyInstance,
          // CommentsList.dummyInstance,
          // AnswersList.dummyInstance,
          SpecsTable.dummyInstance,
          SpecsComparisonTable.dummyInstance,
          // SvgPicture.asset(SvgAssets.upvote, color: Colors.red),
        ],
      ),
      //bottomNavigationBar: BottomNavBar(currentIndex: 2,onTap: (int i)=>{},),
    );
  }
}

