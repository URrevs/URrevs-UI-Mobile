import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/subscreens/company_profile_q_a_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/subscreens/company_profile_reviews_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/posting_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class CompanyProfileScreenArgs {
  String companyId;
  String companyName;
  CompanyProfileScreenArgs({
    required this.companyId,
    required this.companyName,
  });

  static CompanyProfileScreenArgs get defaultArgs => CompanyProfileScreenArgs(
        companyId: '6256b2465f87fa90093a50e6', // Apple
        companyName: 'Apple', // Apple
      );
}

class CompanyProfileScreen extends ConsumerStatefulWidget {
  const CompanyProfileScreen(this.screenArgs, {Key? key}) : super(key: key);

  final CompanyProfileScreenArgs screenArgs;

  static const String routeName = 'CompanyProfileScreen';

  @override
  ConsumerState<CompanyProfileScreen> createState() =>
      _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends ConsumerState<CompanyProfileScreen>
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
        context: context,
        controller: _tabController,
        text: widget.screenArgs.companyName,
        imageUrl: ref.currentUser!.picture,
      ),
      fabLabel: LocaleKeys.addQuestion.tr(),
      fabIcon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      onPressingFab: () {
        Navigator.of(context).pushNamed(
          PostingScreen.routeName,
          arguments: PostingScreenArgs(
            postContentType: PostContentType.question,
            company: Company(
              id: widget.screenArgs.companyId,
              name: widget.screenArgs.companyName,
            ),
          ),
        );
      },
      hideFab: hideFab,
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            CompanyProfileReviewsSubscreen(
                companyId: widget.screenArgs.companyId),
            CompanyProfileQASubscreen(companyId: widget.screenArgs.companyId),
          ],
        ),
      ),
    );
  }
}
