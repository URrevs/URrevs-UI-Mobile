import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/subscreens/company_profile_q_a_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/subscreens/company_profile_reviews_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({Key? key}) : super(key: key);

  static const String routeName = 'CompanyProfileScreen';

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool get hideFab => _tabController.index == 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      appBar: AppBars.appBarOfCompnayProfile(
          context: context, controller: _tabController, text: 'Nokia'),
      fabLabel: LocaleKeys.addQuestion.tr(),
      fabIcon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      onPressingFab: () {},
      hideFab: hideFab,
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            CompanyProfileReviewsSubscreen(),
            CompanyProfileQASubscreen(),
          ],
        ),
      ),
    );
  }
}
