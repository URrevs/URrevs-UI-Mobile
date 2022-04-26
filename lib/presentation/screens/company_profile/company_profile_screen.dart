import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/subscreens/company_profile_q_a_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/subscreens/company_profile_reviews_screen.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({Key? key}) : super(key: key);

  static const String routeName = 'CompanyProfileScreen';

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: LocaleKeys.tabBarReviews.tr()),
              Tab(text: LocaleKeys.tabBarQuestionsAndAnswers.tr()),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CompanyProfileReviewsSubscreen(),
            CompanyProfileQASubscreen(),
          ],
        ),
      ),
    );
  }
}
