import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/subscreens/product_profile_q_a_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/subscreens/product_profile_reviews_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/subscreens/product_profile_specs_subscreen.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class ProductProfileScreen extends StatefulWidget {
  const ProductProfileScreen({Key? key}) : super(key: key);

  static const String routeName = 'ProductProfileScreen';

  @override
  State<ProductProfileScreen> createState() => _ProductProfileScreenState();
}

class _ProductProfileScreenState extends State<ProductProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: LocaleKeys.tabBarReviews.tr()),
              Tab(text: LocaleKeys.tabBarSpecs.tr()),
              Tab(text: LocaleKeys.tabBarQuestionsAndAnswers.tr()),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProductProfileReviewsSubscreen(),
            ProductProfileSpecsSubscreen(),
            ProductProfileQASubscreen(),
          ],
        ),
      ),
    );
  }
}
