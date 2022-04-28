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

  String get fabLabel {
    switch (_tabController.index) {
      case 1:
        return LocaleKeys.compareWithAnotherProduct.tr();
      case 2:
        return LocaleKeys.addQuestion.tr();
      default:
        return LocaleKeys.addReview.tr();
    }
  }

  Widget get fabIcon {
    switch (_tabController.index) {
      case 1:
        return Icon(Icons.compare, size: AppSize.s22);
      case 2:
        return Icon(FontAwesomeIcons.plus, size: AppSize.s16);
      default:
        return Icon(FontAwesomeIcons.plus, size: AppSize.s16);
    }
  }

  VoidCallback get onPressingFab {
    switch (_tabController.index) {
      case 1:
        return () {};
      case 2:
        return () {};
      default:
        return () {};
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
      fabLabel: fabLabel,
      fabIcon: fabIcon,
      onPressingFab: onPressingFab,
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
