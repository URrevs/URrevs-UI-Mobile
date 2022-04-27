import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/bottom_navigation_bar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answer_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answers_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comment_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comments_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/reply.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/see_more_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/review_card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/specs_comparison_table.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/specs_table.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/updated_list_tile.dart';

class DevelopmentScreen extends ConsumerStatefulWidget {
  const DevelopmentScreen({Key? key}) : super(key: key);

  static const String routeName = 'DevelopmentScreen';

  @override
  ConsumerState<DevelopmentScreen> createState() => _DevelopmentScreenState();
}
List<Item> items = [
  Item(itemName: 'Xiaomi Redmi Note 6', type: ItemDescription.Smartphone),
  Item(itemName: 'Xiaomi', type: ItemDescription.Company),
];
class _DevelopmentScreenState extends ConsumerState<DevelopmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        children: [
          UpdatedListTile(title:'قائمة المنتجات المضافة حديثاً',items: items,),
          SizedBox(height: 20),
          // UpdatedListTile(title: 'قائمة الشركات المضافة حديثاً', items: items),
          ProductReviewCard.dummyInstance(),
          // CompanyReviewCard.dummyInstance,
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
    );
  }
}
