import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/subscreens/product_profile_q_a_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/subscreens/product_profile_reviews_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/subscreens/product_profile_specs_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class ProductProfileScreen extends StatefulWidget {
  const ProductProfileScreen({Key? key}) : super(key: key);

  static const String routeName = 'ProductProfileScreen';

  @override
  State<ProductProfileScreen> createState() => _ProductProfileScreenState();
}

class _ProductProfileScreenState extends State<ProductProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  FloatingActionButton get floatingActionButton {
    switch (_tabController.index) {
      case 1:
        return FloatingActionButton.extended(
          onPressed: () {},
          label: Text(LocaleKeys.compareWithAnotherProduct.tr()),
          icon: Icon(Icons.compare, size: AppSize.s22),
        );
      case 2:
        return FloatingActionButton.extended(
          onPressed: () {},
          label: Text(LocaleKeys.addQuestion.tr()),
          icon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
        );
      default:
        return FloatingActionButton.extended(
          onPressed: () {},
          label: Text(LocaleKeys.addReview.tr()),
          icon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      appBar: AppBars.appBarOfProductProfile(
        context: context,
        controller: _tabController,
        text: 'Nokia 7 plus',
      ),
      floatingActionButton: floatingActionButton,
      body: TabBarView(
        controller: _tabController,
        children: [
          ProductProfileReviewsSubscreen(),
          ProductProfileSpecsSubscreen(),
          ProductProfileQASubscreen(),
        ],
      ),
    );
  }
}
