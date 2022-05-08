import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarWithTitle(
        context: context,
        title: LocaleKeys.questionsAboutMyProducts.tr(),
      ),
      body: SafeArea(child: Container()),
    );
  }
}
